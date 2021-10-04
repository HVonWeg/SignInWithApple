//
//  SignInWithAppleButtonView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    
    var appleIdCoordinator: AppleIdCoordinator
    
    var body: some View {
        SignInWithAppleButton(.signIn,
                              onRequest: appleIdCoordinator.onRequest,
                              onCompletion: appleIdCoordinator.didFinishAuthentication)
            .frame(width: 300, height: 40)
            .signInWithAppleButtonStyle(.black)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding()
    }
}
