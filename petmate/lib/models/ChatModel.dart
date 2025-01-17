import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String message;
  DateTime date_time;
  String sender_id;
  String message_id;

  ChatModel({
    required this.date_time,
    required this.message,
    required this.sender_id,
    required this.message_id,
  });

  factory ChatModel.FromJson(
      {required String message_id, required Map<String, dynamic> message}) {
    return ChatModel(
        message_id: message_id,
        date_time: (message['date_time'] as Timestamp).toDate(),
        message: message['message'],
        sender_id: message['sender_id']);
  }
}
