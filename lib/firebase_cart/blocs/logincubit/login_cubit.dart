import 'package:firebase_authentication/authentication_repo.dart';
import 'package:firebase_authentication/src/authexceptionmodels/logingoogle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/logincubit/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  final AuthenticationRepository repository;
  LoginCubit(this.repository):super(LoginInitialState());

  void loginwithgoogle()async{
    try {
     await repository.loginwithgoogle();
     emit(LoginSuccess());
    } on LoginWithGoogleException catch (e) {
      emit(LoginStateFailure(e.message));
    }
  }

}