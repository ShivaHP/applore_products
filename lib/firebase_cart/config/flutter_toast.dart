
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToast{
  static void showtoast(String message){
    Fluttertoast.showToast(msg: message,gravity: ToastGravity.BOTTOM);
  }
}