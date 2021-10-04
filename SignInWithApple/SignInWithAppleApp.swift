//
//  SignInWithAppleApp.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 29.09.21.
//

import SwiftUI

@main
struct SignInWithAppleApp: App {
    
    @ObservedObject private var userauth = UserAuth(storage: UserDefaultStorage())
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    /// The Apple ID Coordinator.
    ///
    /// Should be run always for listening the following notifications, to validate the credential state:
    /// - willEnterForegroundNotification
    /// - credentialRevokedNotification
    private(set) var appleIdCoordinator: AppleIdCoordinator!
    
    init() {
        self.appleIdCoordinator = AppleIdCoordinator(userAuth: self.userauth)
        appDelegate.userAuth = userauth
    }
    
    var body: some Scene {
        WindowGroup {
            if userauth.isLoggedIn {
                HomeView()
                    .environmentObject(userauth)
            } else {
                SignInWithAppleView(appleIDCoordinator: appleIdCoordinator)
                    .environmentObject(userauth)
            }
        }
    }
}
