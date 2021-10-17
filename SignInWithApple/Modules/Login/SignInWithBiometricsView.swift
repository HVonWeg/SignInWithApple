//
//  SwiftUIView.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 02.10.21.
//

import SwiftUI

struct SignInWithBiometricsView: View {
    var body: some View {
        VStack {
            Text("Login via biometrics ... ")
                .foregroundColor(Color.gray)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .background(
            Image(Image.Names.backgroundBlue)
        )
    }
}

struct SignInWithBiometricsView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithBiometricsView()
    }
}
