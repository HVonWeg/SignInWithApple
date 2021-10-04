//
//  AppDelegate.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var userAuth: UserAuth?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Prepare App for UI-Tests - check the launch arguments
        if let userAuth = userAuth {
            LaunchArgumentsHandler().didFinishLaunchingWithOptions(application, userAuth: userAuth)
        }
        
        return true
    }
}
