//
//  HomeView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 30.09.21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var userauth: UserAuth
    
    var body: some View {
        VStack {
            // Welcome
            Spacer()
            if let name = userauth.displayName(), !name.isEmpty {
                Text("Welcome \(name).")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
            } else {
                Text("Welcome! Enjoy your ride.")
                    .bold()
                    .foregroundColor(.black)
                    .padding()
            }
            Spacer()
            // Logout Button
            LogoutButton {
                userauth.logoutUser { }
            }
        }.background(
            Image("background_2")
        )
    }
}
