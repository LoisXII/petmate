class StoreModel {
  String store_id;
  String owner_name;
  String store_name;
  String email;
  String password;
  String number;
  String phone_number;
  String country;
  String country_code;
  String dialcode;
  String? store_image;

  StoreModel({
    required this.country,
    required this.store_id,
    required this.country_code,
    required this.store_image,
    required this.dialcode,
    required this.email,
    required this.number,
    required this.owner_name,
    required this.password,
    required this.phone_number,
    required this.store_name,
  });

  factory StoreModel.FromJson(String id, Map<String, dynamic> data) {
    return StoreModel(
        store_id: id,
        store_image: data['store_image'],
        country: data['country'],
        country_code: data['country_code'],
        dialcode: data['dialcode'],
        email: data['email'],
        number: data['number'],
        owner_name: data['owner_name'],
        password: data['password'],
        phone_number: data['phone_number'],
        store_name: data['store_name']);
  }
}
