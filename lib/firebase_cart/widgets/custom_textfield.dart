import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  final bool isnumeric;
  final String label;
  final String hinttext;
  final Function(String) onchanged;
  const CustomField({Key? key,this.isnumeric=false,this.label="",this.hinttext="",required this.onchanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     
      inputFormatters: [
        isnumeric?FilteringTextInputFormatter.digitsOnly:FilteringTextInputFormatter.deny("")
      ],
      keyboardType: isnumeric?TextInputType.number:TextInputType.name,
      validator: (text){
        if(text==null||text.isEmpty){
          return "Enter a valid $label";
        }
        return null;
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black,width: 0.5)
        )
      ),
    );
  }
}