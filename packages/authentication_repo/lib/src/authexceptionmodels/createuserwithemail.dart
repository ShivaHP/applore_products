class CreatUserWithEmailAndPasswordException {
  final String message;
  CreatUserWithEmailAndPasswordException(this.message);
  factory CreatUserWithEmailAndPasswordException.fromCode(String code){
    switch(code){
      case "weak-password":
      return CreatUserWithEmailAndPasswordException("Password is too weak");
      case "email-already-in-use":
      return CreatUserWithEmailAndPasswordException("Account Already Exist with this Email");
      case "operation-not-allowed":
      return CreatUserWithEmailAndPasswordException("Register Operation Failed");
      case "invalid-email":
      return CreatUserWithEmailAndPasswordException("Invalid Email");
      default:
      return CreatUserWithEmailAndPasswordException("Some unexpected error occured");
      
    }
  }

}