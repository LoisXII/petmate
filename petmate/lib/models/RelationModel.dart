import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petmate/models/PetModel.dart';
import 'package:petmate/models/UserModel.dart';

class RelationModel {
  String relation_id;
  String sender_id;
  String reciver_id;
  DateTime relation_date;
  String status;
  UserModel sender;
  UserModel reciver;
  PetModel sender_pet;
  PetModel reciver_pet;

  RelationModel({
    required this.reciver,
    required this.sender,
    required this.reciver_pet,
    required this.sender_pet,
    required this.status,
    required this.reciver_id,
    required this.relation_date,
    required this.relation_id,
    required this.sender_id,
  });

  factory RelationModel.FromJson({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return RelationModel(
      status: data['status'],
      reciver_id: data["recvier_id"],
      relation_date: (data['date'] as Timestamp).toDate(),
      relation_id: id,
      sender_id: data['sender_id'],
      sender_pet:
          PetModel.FromJson(data: data['sender_pet'] as Map<String, dynamic>),
      reciver_pet:
          PetModel.FromJson(data: data['reciver_pet'] as Map<String, dynamic>),
      sender:
          UserModel.FromJson(data: data['sender_data'] as Map<String, dynamic>),
      reciver: UserModel.FromJson(
          data: data['reciver_data'] as Map<String, dynamic>),
    );
  }
}
