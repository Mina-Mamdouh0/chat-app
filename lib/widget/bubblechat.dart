
import 'package:chatapp/model/message.dart';
import 'package:flutter/material.dart';

import '../constent.dart';

class BubbleChat extends StatelessWidget {
   BubbleChat({
    Key? key,required this.message,
  }) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:const EdgeInsets.all(12),
        margin:const EdgeInsets.symmetric(
            vertical: 8,horizontal: 12
        ),
        decoration:const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
        ),
        child: Text(message.message,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),),
      ),
    );
  }
}

class BubbleChatFormFriend extends StatelessWidget {
  BubbleChatFormFriend({
    Key? key,required this.message,
  }) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:const EdgeInsets.all(12),
        margin:const EdgeInsets.symmetric(
            vertical: 8,horizontal: 12
        ),
        decoration:const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )
        ),
        child: Text(message.message,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),),
      ),
    );
  }
}