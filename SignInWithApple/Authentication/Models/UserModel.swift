import Foundation

/// Represents the details about the user which were provided during initial registration.
struct UserModel: Codable {
    /// The email address to use for user communications.
    let email: String?
    
    /// The components which make up the user's name.  See `displayName(style:)`
    let name: PersonNameComponents?
    
    /// The team scoped identifier Apple provided to represent this user.
    let identifier: String?
    
    /// If true, the App try to register with FaceID on next App cold start.
    ///
    /// TODO: This should be remove into UserSettings (TBD).
    var registerWithBiometrics: Bool = true
}
