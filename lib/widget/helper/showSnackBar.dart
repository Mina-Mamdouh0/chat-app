
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context ,String massage) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(massage),
        action: SnackBarAction(
          label: 'Undo !',
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),));
}