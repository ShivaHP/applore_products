import 'package:flutter/material.dart';
import 'package:flutter_notification/firebase_cart/config/palette.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? callback;
  final bool showloader;
  const CustomButton(
      {Key? key, this.text = "", this.callback, this.showloader = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: purple,
            onPrimary: white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: callback,
        child: showloader
            ? SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
              )
            : Text(
                text,
              ));
  }
}
