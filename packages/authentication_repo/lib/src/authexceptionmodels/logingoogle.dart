
class LoginWithGoogleException implements Exception {
  final String message;
  LoginWithGoogleException(this.message);

  factory LoginWithGoogleException.fromCode(String code) {
    switch (code) {
      case "account-exists-with-different-credential":
        return LoginWithGoogleException("Account Already Exists");
      case "invalid-credential":
        return LoginWithGoogleException("Invalid Credential");
      case "operation-not-allowed":
        return LoginWithGoogleException("Google Service Not Enabled");
      case "user-disabled:":
        return LoginWithGoogleException("Your account is blocked");
      case "user-not-found":
        return LoginWithGoogleException("No user found with this mail");
      case "wrong-password":
        return LoginWithGoogleException("Invalid Password");
      case "invalid-verification-code":
        return LoginWithGoogleException("Your Verification Code Expired");
      case "invalid-verification-id":
        return LoginWithGoogleException("Invalid Verification Id");
      default:
        return LoginWithGoogleException("Google Login Failed");
    }
  }
}