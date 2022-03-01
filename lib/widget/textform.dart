
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
   CustomTextFiled({this.text, this.onChange,this.obscureText=false});
   String?text;
    Function(String)? onChange;
    bool?obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (date){
        if(date!.isEmpty){
          return 'Please Enter The True Date';
        }
      },
      onChanged: onChange,
      style:const TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        hintText: text,
        hintStyle:const TextStyle(
          color: Colors.white
        ),
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
