import 'package:intl/intl.dart';

extension DateConversion on String{
  String todatewithmin({String format="dd-MM-y"}){
    return DateFormat(format).add_jms().format(DateTime.parse(this));
  }
}