//
//  BaseAuthTest.swift
//  SignInWithAppleTests
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import XCTest
@testable import SignInWithApple

class BaseAuthTest: XCTestCase {

    typealias CompletionHandler = () -> Void
    
    /// Specific key for the user, to avoid conflicts with the real key data.
    private let keyUser = "testKeyUser"
    
    // TestData
    let userFamilyName = "MyFamilyName"
    let userGivenName = "Heiko"
    let userEmail = "foobar@gmail.com"
    let userIdentifier = "2738479234"
    var userName: PersonNameComponents {
        var nameComponents = PersonNameComponents()
        nameComponents.familyName = userFamilyName
        nameComponents.givenName = userGivenName
        return nameComponents
    }
    
    lazy var storage = UserDefaultStorage(keyUser: keyUser)
    
    lazy var userAuth = UserAuth(storage: storage)
    
    var user: UserModel {
        UserModel(email: userEmail, name: userName, identifier: userIdentifier)
    }
    
    override func setUpWithError() throws {
        clearData()
    }

    override func tearDownWithError() throws {
        clearData()
    }
    
    private func clearData() {
        UserDefaults.standard.removeObject(forKey: keyUser)
    }
}

// MARK: -- Helper

extension BaseAuthTest {
    
    func storeDefaultUser(
        storeName: Bool = true,
        storeEmail: Bool = true,
        completion: CompletionHandler)
    {
        // Create user
        var email: String?
        var userName: PersonNameComponents?
        if storeEmail {
            email = userEmail
        }
        if storeName {
            userName = self.userName
        }
        let user = UserModel(email: email, name: userName, identifier: userIdentifier)
        
        // Store data
        storage.saveUserData(user, completion: completion)
    }
}
