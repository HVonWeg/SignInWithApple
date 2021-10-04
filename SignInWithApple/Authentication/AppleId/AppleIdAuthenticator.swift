//
//  AppleIdCoordinator.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 30.09.21.
//

import AuthenticationServices

class AppleIdAuthenticator: ObservableObject {
    
    var userAuth: UserAuthStorageable
    
    @Published var errorMessage: String?
    
    init(userAuth: UserAuthStorageable) {
        self.userAuth = userAuth
        
        #if DEBUG
        // For UI Testing, we dont need any observers
        if TestingConstants.uiTestingEnabled {
            return
        }
        #endif
        
        // Adding observer for checking if the user revokes Apple-ID for this app.
        
        // Register Notification: WillEnterForeground
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillEnterForeground(_:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        
        // Register Notification: CredentialRevokedNotification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(credentialRevoke(_:)),
            name: ASAuthorizationAppleIDProvider.credentialRevokedNotification,
            object: nil)
    }
    
    @objc private func applicationWillEnterForeground(_ notification: NSNotification) {
        checkCredentialState()
    }
    
    @objc private func credentialRevoke(_ notification: NSNotification) {
        // If the user revokes the AppleID in the iPhone settings, validating via FaceID is still ok.
        userAuth.invalidateUser(completion: nil)
    }
    
    private func checkCredentialState() {
        // For fetching the credential state of the user, userIdentifier is needed.
        guard let user = userAuth.user, let identifier = user.identifier else {
            return
        }
        // Check the credential state. If not authorized, user data should be cleared.
        // TODO: check what happens when the user logs out (in the iPhone Settings), and register with a new one...
        
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: identifier) { state, error in
            if state != .authorized {
                self.userAuth.invalidateUser(completion: nil)
            }
        }
    }
}

