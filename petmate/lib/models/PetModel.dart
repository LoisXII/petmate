class PetModel {
  String pet_id;
  String gender;
  String pet_type_id;
  String pet_name;
  String pet_age;
  String pet_image;
  String user_name;
  String user_id;
  String pet_type_name;

  PetModel({
    required this.gender,
    required this.pet_age,
    required this.pet_id,
    required this.pet_image,
    required this.pet_type_name,
    required this.pet_name,
    required this.user_id,
    required this.pet_type_id,
    required this.user_name,
  });

  factory PetModel.FromJson({String? id, required Map<String, dynamic> data}) {
    return PetModel(
        gender: data['pet_gender'],
        pet_age: data['pet_age'],
        pet_id: id ?? (data['pet_id'] ?? "null"),
        user_id: data['user_id'],
        pet_image: data['pet_image'],
        pet_name: data['pet_name'],
        pet_type_id: data['pet_type_id'],
        pet_type_name: data['pet_type_name'],
        user_name: data['user_name']);
  }

  Map<String, dynamic> ToJson() {
    return {
      'pet_gender': gender,
      'pet_age': pet_age,
      'pet_id': pet_id,
      'user_id': user_id,
      'pet_image': pet_image,
      'pet_name': pet_name,
      'pet_type_id': pet_type_id,
      'pet_type_name': pet_type_name,
      'user_name': user_name,
    };
  }
}
