//
//  SignInWithAppleFooUITests.swift
//  SignInWithAppleUITests
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import XCTest

class LoggedInUITests: BaseUITest {
    
    func testLoggedIn_availableElements() throws {
        let footerText = app.staticTexts["Welcome Heiko von Wegerer."]
        XCTAssert(footerText.exists)
        
        let button = app.buttons["Logout"]
        XCTAssert(button.exists)
    }
    
    func testLoggedIn_logoutButton() throws {
        // Trigger logout
        let button = app.buttons["Logout"]
        button.tap()
        
        // Login Screen should be visible
        let titleText = app.staticTexts["Discovery"]
        XCTAssert(titleText.exists)
    }
}
