
import 'package:firebase_authentication/src/models/model.dart';

abstract class AuthEvent{


}

class LogoutRequested implements AuthEvent{}

class UserAuthStatusChanged implements AuthEvent{
  final UserModel user;
  UserAuthStatusChanged(this.user);
}

