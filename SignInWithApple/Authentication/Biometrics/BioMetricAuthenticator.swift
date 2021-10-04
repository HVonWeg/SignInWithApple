//
//  BioMetricAuthenticator.swift
//  SignInWithApple
//
//  Created by Heiko von Wegerer on 02.10.21.
//

import Foundation
import LocalAuthentication

class BioMetricAuthenticator {
    
    typealias CompletionHandler = (Bool, Error?) -> Void
    
    // MARK: - Variables
    
    public var allowableReuseDuration: TimeInterval = 0
    
    // MARK: - Singleton
    
    public static let shared = BioMetricAuthenticator()
    
    /// Check for biometric authentication
    func authenticateWithBiometrics(
        reason: String = "Confirm your fingerprint or face to authenticate.",
        fallbackTitle: String? = "",
        cancelTitle: String? = "",
        completion: @escaping CompletionHandler
    ) {
        let context = LAContext()
        context.touchIDAuthenticationAllowableReuseDuration = allowableReuseDuration
        context.localizedFallbackTitle = fallbackTitle
        context.localizedCancelTitle = cancelTitle
        
        // Authenticate
        evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            with: context,
            reason: reason,
            completion: completion)
    }
    
    // MARK: - Private
    
    private func evaluatePolicy(
        _ policy: LAPolicy,
        with context: LAContext,
        reason: String,
        completion: @escaping CompletionHandler
    ) {
        context.evaluatePolicy(policy, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
    
}

// MARK: - Class and static

extension BioMetricAuthenticator {
    
    /// Check if can authenticate with biometrics.
    static var canAuthenticate: Bool {
        var error: NSError?
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }
    
}
