import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/firebase_cart/screens/authentication/login.dart';
import 'package:flutter_notification/firebase_cart/screens/product/create_product_view.dart';
import 'package:flutter_notification/firebase_cart/screens/product/products_list.dart';
import 'package:flutter_notification/firebase_cart/screens/splashscreen.dart';

class AppRoute{
  static Route approutes(RouteSettings settings){
    switch(settings.name){
      case LoginScreen.route:
      return route(LoginScreen());
      case ProductsList.route:
      return route(ProductsList());
      case  CreateProduct.route:
      return route(CreateProduct());
      default:
      return MaterialPageRoute(builder: (context)=>SplashScreen());
    }
  }
}

PageRoute route(Widget screen){
  return PageRouteBuilder(pageBuilder: ((context, animation, secondaryAnimation) => ScaleTransition(scale: animation,child: screen)));
}
