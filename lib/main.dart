import 'package:firebase_authentication/authentication_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_state.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_bloc.dart';
import 'package:flutter_notification/firebase_cart/config/app_routes.dart';
import 'package:flutter_notification/firebase_cart/config/share_pref.dart';
import 'package:flutter_notification/firebase_cart/repository/products_repo.dart';
import 'package:flutter_notification/firebase_cart/screens/authentication/login.dart';
import 'package:flutter_notification/firebase_cart/screens/product/products_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 await SharedPref.initialize();
  runApp(AppView());
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authrepo = AuthenticationRepository();
    final productrepo = ProductsRepo();
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository>(
              create: (context) => authrepo),
          RepositoryProvider<ProductsRepo>(create: (context) => productrepo),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(authrepo)),
          BlocProvider<ProductsBloc>(
              create: (context) => ProductsBloc(productrepo)),
        ], child: AppBloc()));
  }
}

class AppBloc extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();
   AppBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.approutes,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: ((context, state) {
          
              if (state.authstatus == AuthStatus.unauthenticated) {
             
                navigatorkey.currentState?.pushNamed(LoginScreen.route);
              } else if (state.authstatus == AuthStatus.authenticated) {
                navigatorkey.currentState?.pushNamed(ProductsList.route);
              }
            }),
            child: child,
          );
        });
  }
}
