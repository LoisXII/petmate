import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petmate/models/ChatModel.dart';

class ChatProvider with ChangeNotifier {
  TextEditingController message = TextEditingController();

  // chat for currnet room .
  Stream<List<ChatModel>>? chats;

// send message .
  Future<void> sendMessage({
    required String sender_id,
    required List<String> ids,
    required String message,
  }) async {
    // get the chat id .

    ids.sort();
    String chat_id = ids.join("_");
    print("chat id is :$chat_id");

    //chat room id (ref) .
    CollectionReference chatRoom = FirebaseFirestore.instance
        .collection('chats')
        .doc(chat_id)
        .collection('messages');

    // create new chat message
    await FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        // create new meesage
        await chatRoom.doc().set({
          "date_time": DateTime.now(),
          "sender_id": sender_id,
          "message": message,
        });
      },
    );

    print("the new message has been sent successFully !");
    //
  }

  // get message .
  Stream<List<ChatModel>>? getMessage({
    required List<String> ids,
  }) {
    try {
      // get the chat id .
      ids.sort();
      String chat_id = ids.join("_");
      print("get message start");
      return FirebaseFirestore.instance
          .collection('chats')
          .doc(chat_id)
          .collection('messages')
          .orderBy('date_time')
          .snapshots()
          .map((event) => event.docs
              .map((e) =>
                  ChatModel.FromJson(message_id: e.id, message: e.data()))
              .toList());
    } catch (e) {
      print("there is an error in get message : $e");
      return null;
    }
  }
}
