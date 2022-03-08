import 'package:firebase_authentication/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_bloc.dart';

import 'package:flutter_notification/firebase_cart/blocs/logincubit/login_cubit.dart';
import 'package:flutter_notification/firebase_cart/blocs/logincubit/login_state.dart';
import 'package:flutter_notification/firebase_cart/config/flutter_toast.dart';
import 'package:flutter_notification/firebase_cart/screens/product/products_list.dart';

import 'package:flutter_notification/firebase_cart/widgets/customelevatedbutton.dart';

class LoginScreen extends StatelessWidget {
  static const String route="/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  return BlocProvider(
    create: (context)=>LoginCubit(context.read<AuthenticationRepository>()),
    child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/applore_login.png"),
            BlocConsumer<LoginCubit,LoginState>(
              listenWhen: ((previous, current) => previous.runtimeType!=current.runtimeType),
              listener: (context,state){
               
                if(state is LoginSuccess){
                 
                  Navigator.pushNamed(context, ProductsList.route);
                  FlutterToast.showtoast("Login Successful");
                }
              
              },
              builder: (context,state) {
                return CustomButton(text: "Login With Google",callback: (){
                  context.read<LoginCubit>().loginwithgoogle();
                },showloader: state is LoginProcess,);
              }
            )
          ],
        ),
      ),
  );
  }
}