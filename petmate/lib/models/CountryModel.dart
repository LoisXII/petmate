class CountryModel {
  String country_name;
  String country_flag;
  String country_dialcode;
  String country_code;

  CountryModel({
    required this.country_code,
    required this.country_dialcode,
    required this.country_flag,
    required this.country_name,
  });

  factory CountryModel.FromJson(Map<String, dynamic> country) {
    return CountryModel(
        country_code: country['country_code'],
        country_dialcode: country['dial_code'],
        country_flag: country['flag_icon'],
        country_name: country['country_name']);
  }
}
