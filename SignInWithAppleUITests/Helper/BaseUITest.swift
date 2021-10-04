//
//  BaseUITest.swift
//  SignInWithAppleUITests
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import XCTest

class BaseUITest: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = [TestingConstants.Arguments.uiTesting, "\(self.classForCoder)"]
        app.launch()
    }

}
