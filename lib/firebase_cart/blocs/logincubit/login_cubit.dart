import 'package:firebase_authentication/authentication_repo.dart';
import 'package:firebase_authentication/src/authexceptionmodels/logingoogle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/logincubit/login_state.dart';
import 'package:flutter_notification/firebase_cart/config/flutter_toast.dart';

class LoginCubit extends Cubit<LoginState>{
  final AuthenticationRepository repository;
  LoginCubit(this.repository):super(LoginInitialState());

  void loginwithgoogle()async{
    try {
      emit(LoginProcess());
     await repository.loginwithgoogle();
   
    } on LoginWithGoogleException catch (e) {
      FlutterToast.showtoast(e.message);
      emit(LoginStateFailure(e.message));
    }
  }

}