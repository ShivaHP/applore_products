
class LoginWithEmailAndPasswordException implements Exception{
  final String message;
  LoginWithEmailAndPasswordException(this.message);
  factory LoginWithEmailAndPasswordException.fromCode(String code){
    switch(code){
      case "invalid-email":
      return LoginWithEmailAndPasswordException("Invalid Email");
      case "user-disabled":
      return LoginWithEmailAndPasswordException("Your account is blocked");
      case "user-not-found":
      return LoginWithEmailAndPasswordException("Email not found");
      case "wrong-password":
      return LoginWithEmailAndPasswordException("Wrong Password");
      
      default:
      return LoginWithEmailAndPasswordException("Login with Email failed");
    }
  }
}
