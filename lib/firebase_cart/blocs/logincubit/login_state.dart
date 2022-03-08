
abstract class LoginState{

}

class LoginStateFailure  implements LoginState{
  final String message;
  LoginStateFailure(this.message);
}
class LoginInitialState implements LoginState{
}

class LoginSuccess implements LoginState{
}

class LoginProcess implements LoginState{

}