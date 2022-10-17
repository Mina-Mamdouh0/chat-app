
import 'package:chatapp/bloc/state_chat.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ChatCubit extends Cubit<ChatState>{
  ChatCubit() : super(InitialState());
  static ChatCubit get(context)  =>BlocProvider.of(context);


  void loginUser({
  required String email,
  required String password,
})  {
    emit(LoadingLoginState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
       emit(SuccessLoginState());
     }).onError((error, stackTrace){
       emit(ErrorLoginState(error.toString()));
     });
  }

  void registerUser({
    required String email,
    required String password,
})  {
    emit(LoadingSignUpState());
     FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
       emit(SuccessSignUpState());
     }).onError((error, stackTrace){
       emit(ErrorSignUpState(error.toString()));
     });
  }

}