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
    
    // MARK: - Life cycle
    
    init(userAuth: UserAuthStorageable) {
        self.userAuth = userAuth
        
        #if DEBUG
        // For UI Testing, we dont need any observers
        if TestingConstants.uiTestingEnabled {
            return
        }
        #endif
        
        // Adding observer for checking if the user revokes Apple-ID for this app.
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: - Private methods
    
    private func checkCredentialState() {
        // For fetching the credential state of the user, userIdentifier is needed.
        guard let user = userAuth.user, let identifier = user.identifier else {
            return
        }
        // Check the credential state. If not authorized, user data should be cleared.
        // TODO: check what happens when the user logs out (in the iPhone Settings), and register with a new one...
        ASAuthorizationAppleIDProvider().getCredentialState(forUserID: identifier) { state, error in
            if state != .authorized {
                self.invalidateUser()
            }
        }
    }
    
    private func invalidateUser() {
        if userAuth.loggedInStatus == .loggedInViaAppleId {
            userAuth.invalidateUser {
                self.userAuth.logoutUser(completion: nil)
            }
        }
    }
}

// MARK: - Observers

extension AppleIdAuthenticator {
    
    private func addObservers() {
        let center = NotificationCenter.default
        let mainQueue = OperationQueue.main
        
        // Add Observer: will enter foreground
        center.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: mainQueue) { [weak self] notification in
                self?.checkCredentialState()
            }
        
        // Add Observer: credential revoked notification
        center.addObserver(
            forName: ASAuthorizationAppleIDProvider.credentialRevokedNotification,
            object: nil,
            queue: mainQueue) { [weak self] notification in
                self?.invalidateUser()
            }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

