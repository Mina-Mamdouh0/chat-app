import 'package:chatapp/bloc/cubit_chat.dart';
import 'package:chatapp/bloc/state_chat.dart';
import 'package:chatapp/constent.dart';
import 'package:chatapp/widget/button.dart';
import 'package:chatapp/widget/helper/showSnackBar.dart';
import 'package:chatapp/widget/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chatscreen.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static String id='RegisterScreen';
  String? email,password;
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit,ChatState>(
        builder: (context,state){
          var cubit=ChatCubit.get(context);
          return Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: ListView(children: [
                  Image.asset(kLogo,
                    height: 200,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      Text('Scholar Chat',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:const [
                      Text('Register',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  CustomTextFiled(text: 'Email',
                    onChange: (date){
                      email=date;
                    },),
                  const SizedBox(height: 10,),
                  CustomTextFiled(text: 'Password',
                    onChange:(date){
                      password=date;
                    },),
                  const SizedBox(height: 10,),
                 (state is LoadingSignUpState)?
                     const Center(child: CircularProgressIndicator(),):
                 CustomButton(text: 'Register',
                   onTap: (){
                     if(formKey.currentState!.validate()){
                       try {
                         cubit.registerUser(
                             email: email!.trim(),
                             password: password!.trim());
                       } on FirebaseAuthException catch (e) {
                         if (e.code == 'weak-password') {
                           showSnackBar(context,'The password provided is too weak');
                         } else if (e.code == 'email-already-in-use') {
                           showSnackBar(context,'The account already exists for that email.');
                         }
                       } catch (e) {
                         showSnackBar(context,e.toString());
                       }
                     }
                   },),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('do have an account ?',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      GestureDetector(
                        onTap: ()=>Navigator.pop(context),
                        child:const Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),
                    ],
                  ),
                ],
                ),
              ),
            ),
          );
        },
      listener: (context,state){
          if(state is SuccessSignUpState){
            Navigator.pushReplacementNamed(context, ChatScreen.id);
          }

      },
    );
  }


}
