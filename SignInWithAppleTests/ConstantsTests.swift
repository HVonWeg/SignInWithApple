//
//  ConstantsTests.swift
//  SignInWithAppleTests
//
//  Created by Heiko von Wegerer on 15.10.21.
//

import XCTest
import SwiftUI
@testable import SignInWithApple

class ConstantsTests: XCTestCase { }

// MARK: -- Image

extension ConstantsTests {
    
    func testNameBackgroundBlue() throws {
        XCTAssertEqual(Image.Names.backgroundBlue, "background_2")
    }
}
