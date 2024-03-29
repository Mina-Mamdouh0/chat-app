import 'package:chatapp/bloc/cubit_chat.dart';
import 'package:chatapp/screens/chatscreen.dart';
import 'package:chatapp/screens/loginscreen.dart';
import 'package:chatapp/screens/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 /* await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/
  runApp(BlocProvider(
    create: (_)=>ChatCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoginScreen.id:(context)=> LoginScreen(),
        RegisterScreen.id:(context)=> RegisterScreen(),
        ChatScreen.id:(context)=> ChatScreen(),
      },
      initialRoute:FirebaseAuth.instance.currentUser==null? LoginScreen.id:ChatScreen.id,
      //home: const  LoginScreen(),
    );
  }
}
