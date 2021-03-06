//
//  UserAuth.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import Foundation

/// Keeps the logged in Type of the user.
///
/// The user can still log in via FaceId even he revokes the AppleID in the iPhone settings.
enum LoggedInStatus: Int {
    case loggedOut
    case loggedInViaBiometric
    case loggedInViaAppleId
    
    var isLoggedIn: Bool {
        self != .loggedOut
    }
}

class UserAuth: ObservableObject {
    
    // MARK: - Published vars
    
    @Published var user: UserModel?
    
    // Tempory variable, if the user is loggedIn.
    // After a coldstart, the user is always logged out.
    // TODO: Clarify warmstart - when must the user be logged out? (JWT? - credential.identityToken!)
    @Published var loggedInStatus: LoggedInStatus = .loggedOut
    
    var loginWithBiometricsEnabled: Bool {
        get {
            return user?.registerWithBiometrics ?? false
        }
        set {
            guard var user = user else {
                return
            }
            user.registerWithBiometrics = newValue
            storage.saveUserData(user) { }
        }
    }
    
    // MARK: - Private vars
    
    private var storage: UserStorageable
    
    init(storage: UserStorageable) {
        self.storage = storage
        storage.getUserData { userModel in
            self.user = userModel
        }
    }
    
    private func logout(completion: CompletionHandler?) {
        DispatchQueue.main.async {
            self.loggedInStatus = .loggedOut
            self.user = nil
            if let completion = completion {
                completion()
            }
        }
    }
}

// MARK: - Helper

extension UserAuth {
    
    /// Returns the localized name for the person.
    /// - Parameter style: The `PersonNameComponentsFormatter.Style` to use for the display.
    func displayName(style: PersonNameComponentsFormatter.Style = .default) -> String? {
        guard let name = user?.name else {
            return nil
        }
        return PersonNameComponentsFormatter.localizedString(from: name, style: style)
    }
}

// MARK: - UserAuthStorage

extension UserAuth: UserAuthStorageable {
    
    var isLoggedIn: Bool {
        loggedInStatus.isLoggedIn
    }
    
    func registerUser(_ user: UserModel, completion: CompletionHandler?) {
        storage.saveUserData(user) {
            self.user = user
            self.loggedInStatus = .loggedInViaAppleId
            if let completion = completion {
                completion()
            }
        }
    }
    
    func logoutUser(completion: CompletionHandler?) {
        storage.deleteUserData() {
            self.logout(completion: completion)
        }
    }
    
    func invalidateUser(completion: @escaping CompletionHandler) {
        let user = UserModel(email: nil, name: nil, identifier: nil)
        self.user = user
        storage.saveUserData(user, completion: completion)
    }
    
    func signInWithExistingAccount(identifier: String, completion: CompletionHandler?) {
        if user == nil {
            let user = UserModel(email: nil, name: nil, identifier: identifier)
            registerUser(user, completion: completion)
        } else {
            loggedInStatus = .loggedInViaAppleId
            if let completion = completion {
                completion()
            }
        }
    }
}
