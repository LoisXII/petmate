import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:petmate/models/CountryModel.dart';
import 'package:petmate/models/ItemModel.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Registeration_fields_status {
  email,
  username,
  country,
  password,
  phonenumber,
  something_else,
  approved,
  image
}

enum Login_Fields_Status { email, password, something_else, approved }

enum AddPetsFieldStatus {
  image,
  gender,
  pet_name,
  pet_age,
  pet_type_id,
  somethingelse,
  error,
  approved
}

class LocalFunctionProvider with ChangeNotifier {
  // date picker .
  DateTime dateTime = DateTime.now();

  // gender picker .
  String gender = 'male';

  // image choosen .
  XFile? image;

  // list of all countries
  List<CountryModel>? Countries;

  // country choosen .
  CountryModel? countryModel;

  // saved login data .
  String? _savedEmail;
  String? _savedPassword;
  bool isLoginDataChecked = false;

  // cart .
  List<ItemModel> cart = [];

  //  taxes .
  double tax = 0.5;

  // delivery fees .
  double delivery_fees = 1.5;

  // total price for items
  double items_total_price = 0;

  double cart_total_price = 0;

  // full name controller .
  TextEditingController fullname_controller_register = TextEditingController();

  // email controller .
  TextEditingController email_controller_register = TextEditingController();

  // password controller .
  TextEditingController password_controller_register = TextEditingController();

  // phone number
  TextEditingController phoneNumber_controller_register =
      TextEditingController();

  // pet name controller .
  TextEditingController pet_name_controller = TextEditingController();

  // pet age .
  TextEditingController pet_age_controller = TextEditingController();

  //pet type choosen .
  String? pet_type_id;

  // email for login  .
  TextEditingController email_controller_login = TextEditingController();

  // password for login .
  TextEditingController password_controller_login = TextEditingController();

  // add item to cart  .
  void AddItemToCart({required ItemModel item}) {
    cart.add(item);
    GetTotalPriceForItems();
    GetTotalPriceForCart();
    print("item has id (${item.item_id}) has been add to cart  successfully ");
    notifyListeners();
  }

  // delete item from cart .
  void DeleteItemFromCart({required int index}) {
    cart.removeAt(index);
    print("item has index ($index) has been deleted successfully ");
    notifyListeners();
  }

  // get total price of cart .
  double GetTotalPriceForItems() {
    if (cart.isNotEmpty) {
      double price = 0;
      items_total_price = 0;
      notifyListeners();
      for (int a = 0; a < cart.length; a++) {
        double item_price = double.parse(cart[a].item_price);
        price = price + item_price;
      }
      items_total_price = price;
      notifyListeners();
      return price;
    } else {
      return 0;
    }
  }

  //  Get Total Price For Cart including items + tax + delivery fees
  double GetTotalPriceForCart() {
    if (cart.isNotEmpty) {
      // total price for item .
      double items_total_price = GetTotalPriceForItems();
      // get total price for cart .
      cart_total_price = items_total_price + tax + delivery_fees;
      notifyListeners();
      return cart_total_price;
    } else {
      return 0;
    }
  }

  // clear the carts .
  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  // Get Date Time From CupertinoDatePicker .
  DateTime? GetDateTime(DateTime datetime) {
    dateTime = datetime;
    notifyListeners();
    return null;
  }

  // get the gender choosen by user .
  int GetGender(int index) {
    // index 0 => male
    // index 1 => female
    if (index == 0) {
      gender = "male";
    } else {
      gender = "female";
    }
    notifyListeners();
    return index;
  }

  // Get Image .
  Future<XFile?> ChooseImage() async {
    try {
      // image instance .
      XFile? _image =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (_image == null) {
        print("no image choosen !");
      } else {
        print("image choosen successFully ");
      }

      // get new image .
      image = _image;
      notifyListeners();
      print("is image null ? :${_image == null ? "null" : "not null"} ");

      return _image;
    } catch (e) {
      //
      print("there is an error in choose image function : $e");
    }
    return null;
  }

  void GetPetType({required String id}) {
    pet_type_id = id;
    notifyListeners();
  }

  // get Countries From Json File
  Future<void> LoadCountries() async {
    try {
      print("Get Countries Function Has Been Started!");

      // Get json file as json string
      String jsonFile = await rootBundle.loadString('files/countries.json');

      // Decode the json file
      List<dynamic> listOfCountries = jsonDecode(jsonFile);

      // Receive port
      ReceivePort receivePort = ReceivePort();

      // Run another thread
      Isolate isolate = await Isolate.spawn(
          ReadJsonFile, [receivePort.sendPort, listOfCountries]);

      // Get countries
      List<CountryModel> finalCountries =
          await receivePort.first as List<CountryModel>;

      //
      Countries = finalCountries;
      notifyListeners();

      // Close the receive port
      receivePort.close();
      print("The recive port is closed ");

      // Kill the isolate
      isolate.kill();
      print("The new isolate  is closed ");

      print("The countries received are: ${finalCountries.length}");

      print("Get Countries Function Has Been Stopped!");
    } catch (e) {
      print('There is an error in get countries function: $e');
    }
  }

// Read file from json
  static Future<void> ReadJsonFile(List args) async {
    try {
      // send port .
      SendPort sendPort = args[0];

      // list of all countries .
      List<dynamic> listOfCountries = args[1];

      // Parse the countries
      List<CountryModel> countries = listOfCountries
          .map(
            (e) => CountryModel.FromJson(e),
          )
          .toList();

      // Send the countries
      sendPort.send(countries);
    } catch (e) {
      print("There is an error in read json file function: $e");
    }
  }

  // get The Country Choosen.
  void GetCountry(int index) {
    if (Countries != null) {
      countryModel = Countries![index];
      notifyListeners();
    }
  }

  // clear controllers .
  void ClearControllers() {
    fullname_controller_register.clear();
    email_controller_register.clear();
    password_controller_register.clear();
    email_controller_login.clear();
    password_controller_login.clear();
    countryModel = null;
    pet_age_controller.clear();
    pet_name_controller.clear();
    image = null;
    pet_type_id = null;
    phoneNumber_controller_register.clear();
    notifyListeners();
  }

  void ClearImage() {
    image = null;
    notifyListeners();
  }

  Registeration_fields_status CheckRegisterationFields() {
    if (fullname_controller_register.text.isNotEmpty &&
        email_controller_register.text.isNotEmpty &&
        email_controller_register.text.toLowerCase().trim().contains('@') ==
            true &&
        email_controller_register.text.toLowerCase().trim().contains('.com') ==
            true &&
        gender.isNotEmpty &&
        password_controller_register.text.isNotEmpty &&
        password_controller_register.text.trim().length >= 8 &&
        countryModel != null &&
        phoneNumber_controller_register.text.isNotEmpty == true &&
        image != null) {
      print("the registeration feilds status are true ");
      return Registeration_fields_status.approved;
    } else {
      print("the registeration feilds status are false ");
      if (fullname_controller_register.text.isEmpty) {
        return Registeration_fields_status.username;
      } else if (email_controller_register.text.isEmpty ||
          email_controller_register.text.toLowerCase().trim().contains('@') ==
              false ||
          email_controller_register.text
                  .toLowerCase()
                  .trim()
                  .contains('.com') ==
              false) {
        return Registeration_fields_status.email;
      } else if (password_controller_register.text.isEmpty ||
          password_controller_register.text.trim().length < 8) {
        return Registeration_fields_status.password;
      } else if (countryModel == null) {
        return Registeration_fields_status.country;
      } else if (phoneNumber_controller_register.text.isEmpty) {
        return Registeration_fields_status.phonenumber;
      } else if (image == null) {
        return Registeration_fields_status.image;
      } else {
        return Registeration_fields_status.something_else;
      }
    }
  }

  Login_Fields_Status CheckLoginFieldsStatus() {
    if (email_controller_login.text.toLowerCase().trim().isNotEmpty &&
        email_controller_login.text.toLowerCase().trim().contains("@") &&
        email_controller_login.text.toLowerCase().trim().contains(".com") &&
        password_controller_login.text.isNotEmpty &&
        password_controller_login.text.trim().length >= 8) {
      print("login fields status is approved ");
      return Login_Fields_Status.approved;
    } else {
      if (email_controller_login.text.toLowerCase().trim().isEmpty ||
          email_controller_login.text.toLowerCase().trim().contains("@") ==
              false ||
          email_controller_login.text.toLowerCase().trim().contains(".com") ==
              false) {
        print("email has status false ");
        return Login_Fields_Status.email;
      } else if (password_controller_login.text.trim().isEmpty ||
          password_controller_login.text.trim().length < 8) {
        print("password has status false ");
        return Login_Fields_Status.password;
      } else {
        return Login_Fields_Status.something_else;
      }
    }
  }

  // save login
  void SaveLogin({required String email, required String password}) async {
    try {
      // isntace of shared pref .
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // save email
      await preferences.setString('email', email.toLowerCase().trim());

      // save password
      await preferences.setString('password', password.trim());
    } catch (e) {
      print("there is an error in save login function $e");
    }
  }

  // forget login .
  void ForgetLogin() async {
    try {
      // isntace of shared pref .
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // save email
      await preferences.remove('email');
      // save password
      await preferences.remove('password');
    } catch (e) {
      print("there is an error in forget login function $e");
    }
  }

  // check login
  Future<bool> CheckLoginData({required BuildContext context}) async {
    try {
      // isntace of shared pref .
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // save email
      _savedEmail = preferences.get('email') as String?;
      // save password
      _savedPassword = preferences.get('password') as String?;

      // print("email : ${_savedEmail}");
      // print("password : ${_savedPassword}");

      // check .
      if (_savedEmail != null && _savedPassword != null) {
        print("the login data exists ");
        // login
        await context
            .read<FirebaseProvider>()
            .Login(email: _savedEmail!, password: _savedPassword!)
            .whenComplete(
          () {
            print("getting user !");
          },
        );
        isLoginDataChecked = true;
        notifyListeners();
        print("is login checked : $isLoginDataChecked");
        return true;
      } else {
        print("the login data not exists ");
        isLoginDataChecked = true;
        notifyListeners();
        print("is login checked : $isLoginDataChecked");
        return false;
      }
    } catch (e) {
      print("there is an error in Check login Data function $e");
      return false;
    }
  }

  void OpenDrawer(
      {required BuildContext context,
      required GlobalKey<ScaffoldState> scaffold_key}) {
    try {
      // open drawer .
      scaffold_key.currentState?.openDrawer();
    } catch (e) {
      print("there is an error in open drawer function : $e");
    }
  }

  void CloseDrawer(
      {required BuildContext context,
      required GlobalKey<ScaffoldState> scaffold_key}) {
    try {
      // open drawer .
      scaffold_key.currentState?.closeDrawer();
    } catch (e) {
      print("there is an error in Close drawer function : $e");
    }
  }

//   Get Status of AddNew Pet fields
  AddPetsFieldStatus CheckAddPetFieldsStatus() {
    if (image != null &&
        pet_name_controller.text.toLowerCase().trim().isNotEmpty &&
        pet_age_controller.text.toLowerCase().trim().isNotEmpty &&
        pet_type_id != null) {
      print("status of add new pet fields is approved");
      return AddPetsFieldStatus.approved;
    } else {
      print("the status of add new pets fields is not approved ");

      // pet image .
      if (image == null) {
        return AddPetsFieldStatus.image;
      }

      // pet name .
      else if (pet_name_controller.text.toLowerCase().trim().isEmpty == true) {
        return AddPetsFieldStatus.pet_name;
      }
      // pet age .
      else if (pet_age_controller.text.toLowerCase().trim().isEmpty == true) {
        return AddPetsFieldStatus.pet_age;
      }

      // gender.
      else if (pet_type_id == null) {
        return AddPetsFieldStatus.pet_type_id;
      }

      // something eles .
      else {
        return AddPetsFieldStatus.somethingelse;
      }
    }
  }
}
