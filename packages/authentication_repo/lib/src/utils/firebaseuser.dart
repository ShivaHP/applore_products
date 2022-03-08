import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/src/models/usermodel.dart';

extension FirebaseUser on User{
  UserModel toUser(){
    return UserModel(username: this.displayName??"",email: this.email??"",photo: this.photoURL??"",uid: this.uid);
  }
}