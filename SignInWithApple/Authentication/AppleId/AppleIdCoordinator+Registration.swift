//
//  AppleIdCoordinator+Registration.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 30.09.21.
//

import AuthenticationServices

// MARK: - SignInWithApple Handler

extension AppleIdAuthenticator {
    
    func onRequest(_ request: ASAuthorizationAppleIDRequest) {
        // TODO: using nonce and state to prevent replay attacks
        errorMessage = nil
        request.requestedScopes = [.fullName, .email]
    }
    
    func didFinishAuthentication(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResults):
            // Save data / create account in our system
            didCompleteWithAuthorization(authResults: authResults)
        case .failure(let error):
            // Avoid error message for AuthorizationError UserCancel
            if let error = error as? ASAuthorizationError,
               error.code == ASAuthorizationError.canceled {
                return
            }
            
            // Handle Failure
            errorMessage = "Authorization failed, please try again."
        }
    }
    
}

extension AppleIdAuthenticator {
    
    // MARK: - Public methods
    
    func didCompleteWithAuthorization(authResults: ASAuthorization) {
        switch authResults.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
                registerNewAccount(credential: appleIDCredential)
            } else {
                signInWithExistingAccount(credential: appleIDCredential)
            }
        case let passwordCredential as ASPasswordCredential:
            signInWithUserAndPassword(credential: passwordCredential)
            break
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        if let email = credential.email, let fullName = credential.fullName {
            let user = UserModel(email: email, name: fullName, identifier: credential.user)
            // Set new user data + write it to the storage
            userAuth.registerUser(user, completion: nil)
        }
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        // Sign in with credentials the second time only contains the identifier.
        // TODO: credential.realUserStatus
        // New users in the ecosystem will get this value as well, so you should not block these users, but instead treat them as any new user through standard email sign up flows
        userAuth.signInWithExistingAccount(identifier: credential.user, completion: nil)
    }
    
    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        userAuth.signInWithExistingAccount(identifier: credential.user, completion: nil)
    }
}
