//
//  TestingConstants.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

#if DEBUG

import Foundation

struct TestingConstants {
    
    static var uiTestingEnabled = CommandLine.arguments.contains(TestingConstants.Arguments.uiTesting)
    
    struct Arguments {
        static let uiTesting = "--uiTesting"
    }
}

#endif
