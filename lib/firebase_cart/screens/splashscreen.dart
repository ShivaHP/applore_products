import 'package:flutter/material.dart';
import 'package:flutter_notification/firebase_cart/config/share_pref.dart';
import 'package:flutter_notification/firebase_cart/screens/authentication/login.dart';
import 'package:flutter_notification/firebase_cart/screens/product/products_list.dart';

class SplashScreen extends StatelessWidget {
  static const String route="/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handlenavigation(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/applore_splash.png")
          )
        ),
      ),
    );
  }

  handlenavigation(BuildContext context){
    Future.delayed(const Duration(seconds: 2),(){
      String user=SharedPref.getString("user");

      if(user.isEmpty){
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route,(value)=>false);
      }
      else{
        Navigator.pushNamedAndRemoveUntil(context,ProductsList.route,(value)=>false);
   
      }
    });
  }
}