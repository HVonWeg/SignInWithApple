//
//  UserDefaultStorageTests.swift
//  SignInWithAppleTests
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import XCTest
@testable import SignInWithApple

class UserDefaultStorageTests: BaseAuthTest { }

// MARK: - Inital Status

extension UserDefaultStorageTests {
    
    func testUserData_defaultShouldBeNil() throws {
        let expectation = self.expectation(description: "User")
        storage.getUserData { user in
            XCTAssertNil(user)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

// MARK: - Save User Data

extension UserDefaultStorageTests {
    
    func testSaveUserData_withIdentifier() throws {
        let expectation = self.expectation(description: "User data fetched")
        storeDefaultUser(storeName: false, storeEmail: false) {
            storage.getUserData { user in
                if let user = user {
                    XCTAssertNil(user.email)
                    XCTAssertNil(user.name)
                    XCTAssertEqual(user.identifier, userIdentifier)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSaveUserData_withIdentifierAndName() throws {
        let expectation = self.expectation(description: "User data fetched")
        storeDefaultUser(storeEmail: false) {
            storage.getUserData { user in
                if let user = user {
                    XCTAssertNil(user.email)
                    XCTAssertEqual(user.name, userName)
                    XCTAssertEqual(user.identifier, userIdentifier)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSaveUserData_withIdentifierAndEmail() throws {
        let expectation = self.expectation(description: "User data fetched")
        storeDefaultUser(storeName: false) {
            storage.getUserData { user in
                if let user = user {
                    XCTAssertEqual(user.email, userEmail)
                    XCTAssertNil(user.name)
                    XCTAssertEqual(user.identifier, userIdentifier)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testSaveUserData_withAllComponents() throws {
        let expectation = self.expectation(description: "User data fetched")
        storeDefaultUser {
            storage.getUserData { user in
                if let user = user {
                    XCTAssertEqual(user.email, userEmail)
                    XCTAssertEqual(user.name, userName)
                    XCTAssertEqual(user.identifier, userIdentifier)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

// MARK: - Delete User data

extension UserDefaultStorageTests {
    
    func testDeleteUser_getUserShouldBeNil() throws {
        let expectation = self.expectation(description: "user data fetched")
        storeDefaultUser {
            storage.deleteUserData {
                storage.getUserData { user in
                    XCTAssertNil(user)
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}

// MARK: - Invalidate User data

extension UserDefaultStorageTests {
    func testInvalidateUser_userDataFieldsShouldBeNil() throws {
        let expectation = self.expectation(description: "User data fetched")
        storeDefaultUser {
            storage.invalidateUserData {
                self.storage.getUserData { user in
                    if let user = user {
                        XCTAssertNil(user.identifier)
                        XCTAssertNil(user.name)
                        XCTAssertNil(user.name)
                        expectation.fulfill()
                    } else {
                        XCTFail()
                    }
                }
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
