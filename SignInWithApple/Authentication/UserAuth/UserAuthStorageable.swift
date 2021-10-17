//
//  UserAuthStorageable.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 02.10.21.
//

import Foundation

protocol UserAuthStorageable {
    
    typealias CompletionHandler = () -> Void
    
    /// The current logedIn User
    var user: UserModel? { get }
    
    /// Returns true, if the user is logged in.
    var isLoggedIn: Bool { get }
    
    /// Returns the  loggedIn status of the user.
    var loggedInStatus: LoggedInStatus { get }
    
    /// Logouts the user.
    ///
    /// The user data will be also deleted from the UserStorage.
    func logoutUser(completion: CompletionHandler?)
    
    /// Register the given User.
    ///
    /// The user data will be also stored in the UserStorage.
    func registerUser(_ user: UserModel, completion: CompletionHandler?)
    
    /// Invalidates the user data in the storage.
    ///
    /// Email, Name and the Apple-Id is set to nil.
    func invalidateUser(completion: @escaping CompletionHandler)
    
    /// Sign in with the user with the given user.
    ///
    /// Will create a user with the given identifier, if a user is not set.
    func signInWithExistingAccount(identifier: String, completion: CompletionHandler?)
}
