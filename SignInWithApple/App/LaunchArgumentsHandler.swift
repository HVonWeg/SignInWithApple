//
//  LaunchArgumentsHandler.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

import UIKit

struct LaunchArgumentsHandler {
    
    func didFinishLaunchingWithOptions(_ application: UIApplication, userAuth: UserAuth) {
        #if DEBUG
        guard launchArgumentsHandled(userAuth: userAuth) == false else {
            return
        }
        #endif
    }
}
