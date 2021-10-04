# SignInWithApple

Example SwiftUI App to sign in with Apple and Biometrics (FaceID).

### Description
With the app, I wanted to acquire the knowledge of how registration works with AppleID and Biometrics.
The app still needs improvement at various points, these will be implemented over time.
The biggest challenge was the handling of the edge cases (no internet connection, access not allowed, etc.).
However, it was a lot of fun and I will use this in my private project.

### Features
* First Login: Sign in with Apple
* Second Login: also via Biometrics possible
* Coldstart: bypass the Login screen when the user opens the app the second time.
* Warmstart: same screen state as before (should be show the Login Screen after x minutes, see Todo´s)
* Some unit tests and ui tests
* Logout possible

### Building

This project contains no dependencies. Just check out the project and start it on your device.
For testing on the device, you need a provisioning profile with „Sign In with Apple“ enabled.

---

### Todo´s
* create constants for texts
* create color constants
* storage user date into keychain, not in user defaults (not secure!)
* Check what happens when the user logs out (in the iPhone Settings), and register with a new one...
* create User Settings (register with Biometrics should be enabled/disabled by the user)
* Write more unit and UI tests

### To Clarify
* Warmstart: how long is the session valid? Using credential.identityToken?
* sign with existing account: credential realUserStatus - instead treat them as any new user through standard email sign up flows
* AppleId: maybe use nonce and state to prevent replay attacks

---

### Manual Tests
Here you can find some testing scenarios. You can also test no internet connection e.g. Airline mode active.\
Note that the user can disable the use of Face ID and Apple ID at any time in the iPhone settings.

#### - Cancel will not trigger any error messages
GIVEN Login Screen is visible\
WHEN sign in with Apple\
WHEN click on Cancel\
THEN Login Screen is still visible without any error message\

#### - Dont allow Face ID the first time
GIVEN logged in user with AppleId.\
AND never try  with FaceId (new installation - should not displayed in the iPhone App Setting)\
WHEN coldstart\
WHEN system message will appear "may i use Face-ID?"\
WHEN dont allow\
THEN Login screen appears with only one message 'you can skip the manual login process by approving..."\

#### - Logout
GIVEN allready logged in user with biometrics\
WHEN go to the settings and disable Login with biometrics\
WHEN login again with Apple-ID\
WHEN logout\
THEN LoginScreen should be displayed without any error messages\
