//
//  NSObject+Extensions.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 03.10.21.
//

#if DEBUG

import Foundation

extension NSObject {
    
    class func swiftClassFromString(className: String) -> AnyClass! {
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return NSClassFromString("\(appName).\(className)")
        }
        return nil
    }
}

#endif
