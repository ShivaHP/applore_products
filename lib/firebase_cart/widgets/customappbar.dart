import 'package:flutter/material.dart';
import 'package:flutter_notification/firebase_cart/config/palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool centertitle;
  const CustomAppBar({Key? key,this.centertitle=false,this.title=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: white,
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 17),
      leading: IconButton(icon: Icon(Icons.arrow_back_ios_new,color: Colors.black),onPressed: (){
        Navigator.pop(context);
      },),
    title: Text(title),
    centerTitle: centertitle,
    );
  }

  @override
  // TODO: implement child
  Widget get child => Text("");

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 60);
}