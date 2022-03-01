class Message{
  final String message;
  final String id;

  Message(this.message,this.id);
  factory Message.jsonDate(date){
    return Message(date['message'],date['id']);
  }
}