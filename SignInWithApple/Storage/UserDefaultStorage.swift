//
//  UserDefaultStorage.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import Foundation

// TODO: Using UserDefaults for UserInfo is not sercure. Use instead KeyChain.
// TODO: If the user reinstall the app, the user is still logged in, but UserData is empty - we´ll lost name and email.

class UserDefaultStorage {
    private let keyUser: String
    
    init(keyUser: String = "appleUser") {
        self.keyUser = keyUser
    }
}

// MARK: - UserModelPersister

extension UserDefaultStorage: UserStorageable {
    
    func getUserData(completion: GetUserCompletion) {
        if let userData = UserDefaults.standard.object(forKey: self.keyUser) as? Data,
           let user = try? JSONDecoder().decode(UserModel.self, from: userData) {
            completion(user)
        } else {
            print("*** STORAGE: user not found")
            completion(nil)
        }
    }
    
    func saveUserData(_ userData: UserModel, completion: CompletionHandler) {
        if let userEncoded = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(userEncoded, forKey: self.keyUser)
        } else {
            // TODO: handle error
            print("*** STORAGE cant save user data")
        }
        completion()
    }
    
    func deleteUserData(completion: CompletionHandler) {
        UserDefaults.standard.removeObject(forKey: self.keyUser)
        completion()
    }
    
    func invalidateUserData(completion: @escaping CompletionHandler) {
        self.saveUserData(UserModel(email: nil, name: nil, identifier: nil), completion: completion)
    }
}
