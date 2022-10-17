import 'package:chatapp/bloc/cubit_chat.dart';
import 'package:chatapp/bloc/state_chat.dart';
import 'package:chatapp/constent.dart';
import 'package:chatapp/screens/chatscreen.dart';
import 'package:chatapp/screens/registerscreen.dart';
import 'package:chatapp/widget/button.dart';
import 'package:chatapp/widget/helper/showSnackBar.dart';
import 'package:chatapp/widget/textform.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  static String id='LoginScreen';
  String? email,password;
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit,ChatState>(
      builder: (context, state){
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
                    Text('Login',
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
                  obscureText: true,
                  onChange:(date){
                    password=date;
                  },),
                const SizedBox(height: 10,),
                (state is LoadingLoginState)?
                const Center(child: CircularProgressIndicator(),):
                CustomButton(text: 'LOGIN',
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      try {
                         cubit.loginUser(email: email!.trim(),
                             password: password!.trim());

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context,'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context,'Wrong password provided for that user.');
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
                    const Text('don\'t have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    GestureDetector(
                      onTap: ()=>Navigator.pushNamed(context, RegisterScreen.id),
                      child:const Text('Register',
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
      listener: (context, state){
        if(state is SuccessLoginState){
          Navigator.pushReplacementNamed(context, ChatScreen.id,arguments: email);
        }
      },
    );
  }




}
