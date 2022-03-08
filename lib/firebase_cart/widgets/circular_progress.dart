import 'package:flutter/material.dart';
import 'package:flutter_notification/firebase_cart/config/palette.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(purple),),
    );
  }
}