import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String user_id;
  String username;
  String email;
  String password;
  String country;
  String country_code;
  String dialcode;
  String gender;
  String number;
  String phone_number;
  DateTime date_of_birth;
  String image_url;

  UserModel({
    required this.country,
    required this.user_id,
    required this.country_code,
    required this.date_of_birth,
    required this.dialcode,
    required this.image_url,
    required this.email,
    required this.gender,
    required this.number,
    required this.password,
    required this.phone_number,
    required this.username,
  });

  factory UserModel.FromJson(
      {String? user_id, required Map<String, dynamic> data}) {
    return UserModel(
        user_id: user_id ?? (data['user_id'] ?? "null"),
        country: data['country'],
        image_url: data['image'],
        country_code: data['country_code'],
        date_of_birth: (data['date_of_birth'] as Timestamp).toDate(),
        dialcode: data['dialcode'],
        email: data['email'],
        gender: data['gender'],
        number: data['number'],
        password: data['password'],
        phone_number: data['phone_number'],
        username: data['user_name']);
  }

  Map<String, dynamic> ToJson() {
    return {
      'user_id': user_id,
      'country': country,
      'country_code': country_code,
      'date_of_birth': date_of_birth,
      'dialcode': dialcode,
      'email': email,
      'image': image_url,
      'gender': gender,
      'number': number,
      'password': password,
      'phone_number': phone_number,
      'user_name': username,
    };
  }
}
