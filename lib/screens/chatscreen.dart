import 'package:chatapp/constent.dart';
import 'package:chatapp/model/message.dart';
import 'package:chatapp/widget/bubblechat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatelessWidget {
   String? email;
   ChatScreen({Key? key, this.email}) : super(key: key);
  static String id='ChatScreen';
   ScrollController scrollController=ScrollController();
   TextEditingController controller=TextEditingController();
   CollectionReference message = FirebaseFirestore.instance.collection(kCollectionReference);

  @override
  Widget build(BuildContext context) {
    var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('created',descending: true).snapshots(),
        builder: (context,snapshot){
        if(snapshot.hasData){
          List<Message> messageList=[];
          for(int i=0;i<snapshot.data!.docs.length;i++){
            messageList.add(Message.jsonDate(snapshot.data!.docs[i]));
          }
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(kLogo,
                        height: 50),
                    const Text('Scholar Chat')
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      reverse: true,
                      itemCount: messageList.length,
                        itemBuilder: (context,index){
                          return  messageList[index].id==email?
                          BubbleChat(message: messageList[index],):
                          BubbleChatFormFriend(message: messageList[index],);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:controller ,
                      decoration: const InputDecoration(
                        hintText: 'message',
                        suffixIcon: Icon(Icons.send,
                          color: kPrimaryColor,),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kPrimaryColor,
                                width: 2
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kPrimaryColor,
                                width: 1
                            )
                        ),
                      ),
                      onSubmitted: (date){
                        message.add({
                          'message': date,
                          'created':DateTime.now(),
                          'id':email,
                        });
                        scrollController.animateTo(
                          0,
                          duration:const Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                        controller.clear();
                      },
                    ),
                  ),
                ],
              )
          );
        }else{
          return const Text('Loading...');
        }
        });
  }


}


