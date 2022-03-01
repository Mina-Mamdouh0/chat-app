import 'package:chatapp/constent.dart';
import 'package:chatapp/screens/chatscreen.dart';
import 'package:chatapp/screens/registerscreen.dart';
import 'package:chatapp/widget/button.dart';
import 'package:chatapp/widget/helper/showSnackBar.dart';
import 'package:chatapp/widget/textform.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  static String id='LoginScreen';
  String? email,password;
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
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
            CustomButton(text: 'LOGIN',
              onTap: ()async{
                if(formKey.currentState!.validate()){
                  try {
                    await loginUser();
                    Navigator.pushReplacementNamed(context, ChatScreen.id,arguments: email);
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
  }



  Future<void> loginUser() async {
    await Firebase.initializeApp();
     await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
    );
  }
}
