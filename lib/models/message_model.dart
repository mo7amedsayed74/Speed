class MessageModel {
  late final String text;
  late final String senderId;
  late final String receiverId;
  late final String dateTime;

  MessageModel({required this.text, required this.senderId, required this.receiverId, required this.dateTime});

  MessageModel.fromFirebase(Map<String, dynamic> message) {
    text = message['text'];
    senderId = message['senderId'];
    receiverId = message['receiverId'];
    dateTime = message['dateTime'];
  }

  Map<String, dynamic> msgToMap() {
    return {
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
    };
  }
}
