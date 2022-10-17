abstract class ChatState{}

class InitialState extends ChatState{}


class LoadingLoginState extends ChatState{}
class SuccessLoginState extends ChatState{}
class ErrorLoginState extends ChatState{
  final String error;
  ErrorLoginState(this.error);
}

class LoadingSignUpState extends ChatState{}
class SuccessSignUpState extends ChatState{}
class ErrorSignUpState extends ChatState{
  final String error;
  ErrorSignUpState(this.error);
}