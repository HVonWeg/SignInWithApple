//
//  ErrorMessageView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 02.10.21.
//

import SwiftUI

struct ErrorMessageView: View {
    
    @Binding var errorMessage: String?
    
    var body: some View {
        if let errorMessage = errorMessage {
            HStack {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width:24, height: 24)
                Text(errorMessage)
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(.red)
        }
    }
}
