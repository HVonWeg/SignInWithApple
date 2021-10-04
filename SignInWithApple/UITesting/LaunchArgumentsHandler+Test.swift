//
//  LaunchArgumentsHandler+Test.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

#if DEBUG

import Foundation
import UIKit
import SwiftUI

extension LaunchArgumentsHandler {
    
    func launchArgumentsHandled(userAuth: UserAuth) -> Bool {
        if CommandLine.arguments.contains(TestingConstants.Arguments.uiTesting) {
            handleUITesting(userAuth: userAuth)
            return true
        }
        
        return false
    }
    
    private func handleUITesting(userAuth: UserAuth) {
        guard let index = CommandLine.arguments.firstIndex(of: TestingConstants.Arguments.uiTesting) else {
            return
        }
        let uiTestClassName = CommandLine.arguments[index + 1]
        
        // Delete default storage
        deleteStorage()
        
        // Setup testdata for UITest
        if let uiTestClass = NSObject.swiftClassFromString(className: uiTestClassName) as? NSObject.Type,
           let instance = uiTestClass.init() as? UITestable {
            instance.prepareUITest(userAuth: userAuth)
        } else {
            print("*** UITestable class not found: \(uiTestClassName)")
        }
    }
    
    private func deleteStorage() {
        UserDefaultStorage().deleteUserData {}
    }
}

#endif
