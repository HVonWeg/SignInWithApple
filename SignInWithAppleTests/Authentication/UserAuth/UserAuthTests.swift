//
//  UserAuthTests.swift
//  SignInWithAppleTests
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import XCTest
@testable import SignInWithApple

class UserAuthTests: BaseAuthTest { }

// MARK: - Inital Status

extension UserAuthTests {
    
    func testLoggedInStatus_defaultShouldBeLoggedOut() throws {
        XCTAssertTrue(userAuth.loggedInStatus == .loggedOut)
    }
    
    func testFaceIdEnabled_defaultShouldBeFalse() throws {
        XCTAssertFalse(userAuth.loginWithBiometricsEnabled)
    }
    
    func testIsLoggedIn_defaultShouldBeFalse() throws {
        XCTAssertFalse(userAuth.isLoggedIn)
    }
    
    func testIsLoggedIn_defaultUserShouldBeNil() throws {
        XCTAssertNil(userAuth.user)
    }
}

// MARK: - Display Name

extension UserAuthTests {
    
    func testDisplayName_withValidName() {
        storeDefaultUser {
            let name = PersonNameComponentsFormatter.localizedString(from: userName, style: .default)
            XCTAssertEqual(name, userAuth.displayName())
        }
    }
    
    func testDisplayName_withInValidName() {
        storeDefaultUser {
            userAuth.logoutUser {
                XCTAssertNil(self.userAuth.displayName())
            }
        }
    }
}

// MARK: - Login with Face Id enabled

extension UserAuthTests {
    
    func testLoginWithBiometricsEnabled() {
        storeDefaultUser {
            XCTAssertTrue(userAuth.loginWithBiometricsEnabled)
        }
    }
    
    func testLoginWithBiometricsEnabled_setTrue() {
        storeDefaultUser {
            userAuth.loginWithBiometricsEnabled = true
            if let user = userAuth.user {
                XCTAssertTrue(user.registerWithBiometrics)
            } else {
                XCTFail()
            }
        }
    }
    
    func testLoginWithBiometricsEnabled_setFalse() {
        storeDefaultUser {
            userAuth.loginWithBiometricsEnabled = false
            if let user = userAuth.user {
                XCTAssertTrue(user.registerWithBiometrics)
            } else {
                XCTFail()
            }
        }
    }
    
    func testLoginWithBiometricsEnabled_withoutUser() {
        userAuth.loginWithBiometricsEnabled = false
        XCTAssertNil(userAuth.user?.registerWithBiometrics)
    }
}

// MARK: - Register User

extension UserAuthTests {
    
    func testRegisterUser_userShouldBeLoggedIn() throws {
        let expectation = self.expectation(description: "User should be registered")
        userAuth.registerUser(user) {
            XCTAssertNotNil(self.userAuth.user)
            XCTAssertTrue(self.userAuth.isLoggedIn)
            XCTAssertTrue(self.userAuth.loggedInStatus == .loggedInViaAppleId)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

// MARK: - Logout User

extension UserAuthTests {
    
    func testLogoutUser_userShouldBeNil() throws {
        let expectation = self.expectation(description: "User should be logget out")
        userAuth.registerUser(user) {
            self.userAuth.logoutUser {
                XCTAssertNil(self.userAuth.user)
                XCTAssertFalse(self.userAuth.isLoggedIn)
                XCTAssertTrue(self.userAuth.loggedInStatus == .loggedOut)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

// MARK: - Invalidate User

extension UserAuthTests {
    
    func testInvalidateUser_userLoggedInViaAppleId() throws {
        let expectation = self.expectation(description: "User should be invalidated")
        userAuth.registerUser(user) {
            self.userAuth.invalidateUser {
                XCTAssertNil(self.userAuth.user)
                XCTAssertFalse(self.userAuth.isLoggedIn)
                XCTAssertTrue(self.userAuth.loggedInStatus == .loggedOut)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    /// Invalidating a logged in user Biometric should be still loggedIn.
    func testInvalidateUser_userLoggedInViaBiometrics() throws {
        let expectation = self.expectation(description: "User should be invalidated")
        userAuth.registerUser(user) {
            self.userAuth.loggedInStatus = .loggedInViaBiometric
            self.userAuth.invalidateUser {
                XCTAssertNotNil(self.userAuth.user)
                XCTAssertTrue(self.userAuth.isLoggedIn)
                XCTAssertTrue(self.userAuth.loggedInStatus == .loggedInViaBiometric)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

// MARK: - Sign in with existing User

extension UserAuthTests {
    
    /// In case if the user is registered with Apple Id, but reinstalled the app (user data lost).
    func testSignInWithExistingAccount_withNoRegisteredUser() throws {
        let expectation = self.expectation(description: "User should be invalidated")
        userAuth.signInWithExistingAccount(identifier: userIdentifier) {
            if let user = self.userAuth.user {
                XCTAssertNil(user.email)
                XCTAssertNil(user.name)
                XCTAssertEqual(user.identifier, self.userIdentifier)
                XCTAssertTrue(self.userAuth.isLoggedIn)
                XCTAssertTrue(self.userAuth.loggedInStatus == .loggedInViaAppleId)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSignInWithExistingAccount_withRegisteredUser() throws {
        let expectation = self.expectation(description: "User should be invalidated")
        storeDefaultUser {
            userAuth.signInWithExistingAccount(identifier: userIdentifier) {
                XCTAssertEqual(self.user.email, self.userEmail)
                XCTAssertEqual(self.user.name, self.userName)
                XCTAssertEqual(self.user.identifier, self.userIdentifier)
                XCTAssertTrue(self.userAuth.isLoggedIn)
                XCTAssertTrue(self.userAuth.loggedInStatus == .loggedInViaAppleId)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
