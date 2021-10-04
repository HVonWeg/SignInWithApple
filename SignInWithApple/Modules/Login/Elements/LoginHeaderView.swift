//
//  LoginHeaderView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 29.09.21.
//

import SwiftUI

struct LoginHeaderView: View {
    
    var body: some View {
        Group {
            // TODO: create color constants
            Image(systemName: "bicycle.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140, height: 140)
                .foregroundColor(Color(red: 0.588, green: 0.082, blue: 0.11))
            Text("Discovery")
                .font(.title)
                .bold()
                .foregroundColor(.black)
            Text("Discover Pennsylvania with our e-bikes.")
                .foregroundColor(Color.gray)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
}
