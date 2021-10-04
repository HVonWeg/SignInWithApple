//
//  SignInWithAppleUITests.swift
//  SignInWithAppleUITests
//
//  Created by Heiko von Wegerer on 29.09.21.
//

import XCTest

class SignInWithAppleUITests: BaseUITest {

    func testLoginForm_availableElements() throws {
        // Default start - check if all elements present
        let image = app.images["bicycle.circle"]
        XCTAssert(image.exists)
        
        let background = app.images["background_2"]
        XCTAssert(background.exists)
        
        let titleText = app.staticTexts["Discovery"]
        XCTAssert(titleText.exists)
        
        let footerText = app.staticTexts["Discover Pennsylvania with our e-bikes."]
        XCTAssert(footerText.exists)
        
        let button = app.buttons["Sign in with Apple"]
        XCTAssert(button.exists)
    }
}
