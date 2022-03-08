
import 'dart:async';
import 'dart:convert';

import 'package:firebase_authentication/authentication_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_event.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_state.dart';
import 'package:flutter_notification/firebase_cart/config/share_pref.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  late StreamSubscription _authsubscription;
  final AuthenticationRepository authenticationRepository;
  AuthBloc(this.authenticationRepository):super(AuthState()){
    on<LogoutRequested>(_onlogoutrequested);
    on<UserAuthStatusChanged>(_onuserstatuschanges);
    this._authsubscription=authenticationRepository.getuser().listen((event) {
      this.add(UserAuthStatusChanged(event));
     });
  }
  @override
  Future<void> close()async{
    _authsubscription.cancel();
    super.close();
  }



  _onlogoutrequested(LogoutRequested event,Emitter<AuthState> emit){
    authenticationRepository.logoutuser();
    emit(AuthState.unauthenticatd());
  }

  _onuserstatuschanges(UserAuthStatusChanged event,Emitter<AuthState> emit){
    print(event.user.toJson());
    if(event.user.email.isNotEmpty){
  
      SharedPref.setString(key: "user", value: jsonEncode(event.user));
    }
    else{
     
      emit(AuthState.unauthenticatd());
    }
  }


}