//
//  SignInWithAppleView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 29.09.21.
//

import SwiftUI
import LocalAuthentication

struct SignInWithAppleView: View {
    
    // States
    @State private var forceLogin = false
    
    @State private var hintMessage: String? = nil
    @State private var errorMessage: String? = nil
    
    @State private var signInWithBiometricsEnabled = false
    
    // Obserable objects
    @EnvironmentObject var userauth: UserAuth
    @ObservedObject var appleIDCoordinator: AppleIdCoordinator
    
    var shouldTryBiometricAuthentication: Bool {
        userauth.user != nil
        && !forceLogin
        && !userauth.isLoggedIn
        && userauth.loginWithBiometricsEnabled
        && BioMetricAuthenticator.canAuthenticate
    }
    
    var body: some View {
        if shouldTryBiometricAuthentication {
            // Splash Screen for Login with FaceID
            SignInWithBiometricsView()
                .onAppear {
                    authenticateWithBiometrics()
                }
        } else {
            // Login Screen
            
            // Content
            VStack {
                Spacer()
                // Login Header Vierw
                LoginHeaderView()
                Spacer()
                
                // Error and Hint Messages
                Group {
                    // Error Message View for AppleCoordinator
                    ErrorMessageView(errorMessage: $appleIDCoordinator.errorMessage)
                    // Error Message View for BioMetricAuthenticator
                    ErrorMessageView(errorMessage: $errorMessage)
                    // Hint Message View for BioMetricAuthenticator
                    HintMessageView(hintMessage: $hintMessage)
                }.padding()
                
                // Sign in with Biometric Button
                if userauth.user != nil && signInWithBiometricsEnabled {
                    LoginBiometricButtonView(onClickAction: authenticateWithBiometrics)
                }
                
                // Sign in with Apple Button
                SignInWithAppleButtonView(appleIdCoordinator: appleIDCoordinator)
                
                Spacer()
                    .frame(height: 50)
                
            }.background(
                Image("background_2")
            ).onAppear {
                canAuthenticationWithBiometrics()
            }
        }
    }
    
    private func clearMessages() {
        errorMessage = nil
        hintMessage = nil
    }
    
    private func canAuthenticationWithBiometrics() {
        let canAuthenticate = BioMetricAuthenticator.canAuthenticate
        if !canAuthenticate && userauth.user != nil {
            hintMessage = "You can skip the manual login process by approving the biometrics in the App settings."
            errorMessage = nil
        }
        signInWithBiometricsEnabled = canAuthenticate
    }
}

// MARK: - Biometric Authentication

extension SignInWithAppleView {
    
    func authenticateWithBiometrics() {
        // TODO: move the code to the BioMetricAuthenticator
        clearMessages()
        
        guard BioMetricAuthenticator.canAuthenticate else {
            forceLogin = true
            return
        }
        
        BioMetricAuthenticator.shared.authenticateWithBiometrics { success, error in
            if success {
                // Handle successful authentication
                userauth.loggedInStatus = .loggedInViaBiometric
                userauth.loginWithBiometricsEnabled = true
            } else {
                forceLogin = true
                
                // In case of an error, we avoid trying to login with biometric the next start
                if BioMetricAuthenticator.canAuthenticate {
                    userauth.loginWithBiometricsEnabled = false
                }
                
                guard let errorr = error else {
                    return
                }
                switch(errorr) {
                case LAError.userFallback:
                    hintMessage = "Please retry Login with Biometrics or sign in with Apple."
                case LAError.userCancel:
                    hintMessage = nil
                default:
                    errorMessage = "Can´t log in via biometrics: \(errorr.localizedDescription)"
                    break
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let storage = UserDefaultStorage()
        let userAuth = UserAuth(storage: storage)
        SignInWithAppleView(
            appleIDCoordinator: AppleIdCoordinator(userAuth: userAuth)
        ).environmentObject(userAuth)
    }
}
