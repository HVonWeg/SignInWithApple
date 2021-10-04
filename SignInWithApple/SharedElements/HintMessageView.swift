//
//  ErrorHintView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 01.10.21.
//

import SwiftUI

struct HintMessageView: View {
    
    @Binding var hintMessage: String?
    
    var body: some View {
        if let hintMessage = hintMessage {
            HStack {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text(hintMessage)
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(.gray)
        }
    }
}
