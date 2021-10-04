//
//  LogoutButton.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import SwiftUI

struct LogoutButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text("Logout")
                    .bold()
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
            .background(Color.black)
            .cornerRadius(5)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .padding()
        })
    }
}
