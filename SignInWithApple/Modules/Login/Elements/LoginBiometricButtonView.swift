//
//  LoginBiometricButtonView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import SwiftUI

struct LoginBiometricButtonView: View {
    
    var onClickAction: () -> Void
    
    var body: some View {
        Button {
            onClickAction()
        } label: {
            HStack(spacing: 32) {
                Image(systemName: "faceid")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                Text("Login with Biometrics")
                    .bold()
                    .font(.system(size: 16))
            }
            .foregroundColor(.white)
        }
        .frame(width: 300, height: 40)
        .background(Color.black)
        .cornerRadius(6)
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding()
    }
}
