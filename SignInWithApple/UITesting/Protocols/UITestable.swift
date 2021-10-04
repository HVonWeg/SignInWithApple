//
//  UITestable.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

#if DEBUG

import Foundation

protocol UITestable {
    func prepareUITest(userAuth: UserAuth)
}

#endif
