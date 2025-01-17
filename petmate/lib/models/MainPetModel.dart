class MainPetModel {
  String mainPet_id;
  String pet_type;
  MainPetModel({
    required this.mainPet_id,
    required this.pet_type,
  });

  factory MainPetModel.FromJson(
      {required String id, required Map<String, dynamic> data}) {
    return MainPetModel(mainPet_id: id, pet_type: data['pet_type']);
  }
}
