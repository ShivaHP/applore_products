import 'dart:convert';

import 'package:firebase_authentication/src/models/usermodel.dart';
import 'package:flutter_notification/firebase_cart/config/share_pref.dart';

enum AuthStatus{authenticated,unauthenticated}

class AuthState{
  late final AuthStatus _authStatus;
  late final UserModel _user;

  AuthState({AuthStatus? authstatus,UserModel? user}){
    this._authStatus=authstatus??AuthStatus.authenticated;
    this._user=user??UserModel();
  }

  AuthStatus get authstatus=>this._authStatus;
  
  UserModel get user=>this._user;
  AuthState.authenticated(UserModel user){
    this._authStatus=AuthStatus.authenticated;
    this._user=user;
    SharedPref.setString(key: "user", value: jsonEncode(user));
  }
  AuthState.unauthenticatd(){
    SharedPref.preferences.clear();
    this._authStatus=AuthStatus.unauthenticated;
  }

}