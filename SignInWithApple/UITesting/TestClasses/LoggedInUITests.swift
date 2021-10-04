//
//  LoggedInUITests.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

#if DEBUG
import Foundation

class LoggedInUITests: NSObject, UITestable {
    
    func prepareUITest(userAuth: UserAuth) {
        var nameComponents = PersonNameComponents()
        nameComponents.familyName = "von Wegerer"
        nameComponents.givenName = "Heiko"
        let user = UserModel(email: "foobar@gmail.com", name: nameComponents, identifier: "388484833823")
        userAuth.registerUser(user) { }
    }
}

#endif
