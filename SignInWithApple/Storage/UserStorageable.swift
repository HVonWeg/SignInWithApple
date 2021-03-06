//
//  UserStorageable.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import Foundation

protocol UserStorageable {
    
    typealias CompletionHandler = () -> Void
    typealias GetUserCompletion = (UserModel?) -> Void
    
    /// Read the user data from the storage.
    func getUserData(completion: @escaping GetUserCompletion) 
    
    /// Store the user data information into the storage.
    func saveUserData(_ userData: UserModel, completion: @escaping CompletionHandler)
    
    /// Delete the all Info User infos from the storage.
    /// Should be used for logut.
    func deleteUserData(completion: @escaping CompletionHandler)
}
