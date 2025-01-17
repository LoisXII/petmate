import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petmate/models/ItemModel.dart';
import 'package:petmate/models/MainPetModel.dart';
import 'package:petmate/models/OrderModel.dart';
import 'package:petmate/models/PetModel.dart';
import 'package:petmate/models/RelationModel.dart';
import 'package:petmate/models/StoreModel.dart';
import 'package:petmate/models/UserModel.dart';

enum OrderStatusEnum { hold, accept, cancel }

enum LoginStatus {
  user_found_password_match,
  user_found_password_no_match,
  user_not_found,
  error,
}

class FirebaseProvider with ChangeNotifier {
  // list of all  stores
  List<StoreModel>? stores;

  // single store .
  StoreModel? currnet_store;

  // get items .
  List<ItemModel>? items;

  // current user  .
  UserModel? currnet_user;

  // get main pets type
  List<MainPetModel>? mainPetsType;

  // get user_pets .
  List<PetModel>? currnet_user_pets;

  // others pets for breed
  List<PetModel>? breedResult;

  // get currnet pet's owner
  UserModel? owner_for_currnet_pet;

  // get pets for currnet owner .
  List<PetModel>? pets_for_currnet_owner;

  // get currnet user relation .
  List<RelationModel>? currnet_user_relations;

  // orders .
  List<OrderModel>? orders;

  // Get Stores .
  Future GetStores() async {
    stores = await FirebaseFirestore.instance.collection('stores').get().then(
          (value) => value.docs
              .map(
                (e) => StoreModel.FromJson(e.id, e.data()),
              )
              .toList(),
        );

    print(
        "stores :$stores , length : ${stores == null ? 'null' : stores!.length} , not null");

    // update ui
    notifyListeners();
  }

  // get single store .
  Future GetSingleStore({required String store_id}) async {
    currnet_store = await FirebaseFirestore.instance
        .collection('stores')
        .doc(store_id)
        .get()
        .then(
          (value) =>
              // check if exists or not .
              value.exists == true
                  ? StoreModel.FromJson(
                      value.id,
                      value.data()!,
                    )
                  : null,
        );
    print(
        "currnet_store :$currnet_store , is null : ${currnet_store == null ? 'null' : ' not null'}");

    // update ui
    notifyListeners();
  }

  //  get items for currnet store .
  Future GetItems({required String store_id}) async {
    try {
      items = await FirebaseFirestore.instance
          .collection('items')
          .where('store_id', isEqualTo: store_id)
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => ItemModel.FromJson(item_id: e.id, data: e.data()),
                )
                .toList(),
          );

      print("items : $items  , items length : ${items == null ? "null" : {
          "${items!.length} not null"
        }}");

      // update the ui .
      notifyListeners();
    } catch (e) {
      print("there is an error in get items function  : $e");
    }
  }

  // set new order .
  Future Create_Order({
    required String store_id,
    required String user_id,
    required String user_name,
    required List<ItemModel> items,
    required double items_total_price,
    required double cart_total_price,
    required double delivery_fees,
    required double tex_fees,
    required String status,
    required String phone_number,
  }) async {
    try {
      // create new order .
      await FirebaseFirestore.instance.collection('orders').doc().set({
        "user_id": user_id.trim(),
        "store_id": store_id.trim(),
        "user_name": user_name.toLowerCase().trim(),
        "item_total_price": items_total_price,
        "cart_total_price": cart_total_price,
        'delivery_fees': delivery_fees,
        "tax_fees": tex_fees,
        "phone_number": phone_number,
        "status": status.toLowerCase().trim(),
        "order_date": DateTime.now(),
        "items": items
            .map(
              (e) => e.ToJSon(),
            )
            .toList(),
      });
    } catch (e) {
      print("there is an error in create new order function : $e");
    }
  }

  void clear() {
    currnet_store = null;
    items = null;
    notifyListeners();
  }

  // login function .
  Future<LoginStatus> Login({
    required String email,
    required String password,
  }) async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email.toLowerCase().trim())
          .get()
          .then(
        (value) {
          // check if the user exists .
          // check
          // user exists
          if (value.docs.isNotEmpty == true) {
            // get user model
            UserModel user = UserModel.FromJson(
                user_id: value.docs.first.id, data: value.docs.first.data());
            // check the password .

            // check .
            // password match .
            if (password.trim() == user.password) {
              currnet_user = user;
              print("user found (${user.email}) password match");
              notifyListeners();
              return LoginStatus.user_found_password_match;
            }
            // password not match
            else {
              print("user found (${user.email}) password not match");

              return LoginStatus.user_found_password_no_match;
            }
          }

          // the user not exists
          else {
            print("user not found !");
            return LoginStatus.user_not_found;
          }
        },
      );
    } catch (e) {
      print("there is an error in login function :$e");
      return LoginStatus.error;
    }
  }

  // registeration function
  Future RegisterationUser({
    required String user_name,
    required String email,
    required String gender,
    required String password,
    required DateTime date_of_birth,
    required String country,
    required String number,
    required XFile image,
    required String country_code,
    required String dialcode,
  }) async {
    try {
      // image ref .
      Reference imageRef = FirebaseStorage.instance.ref('users/${image.name}');
      // put file .
      await imageRef.putFile(File(image.path));

      // image get url
      String image_url = await imageRef.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc().set({
        "user_name": user_name,
        "email": email,
        "image": image_url,
        "gender": gender,
        "password": password,
        "date_of_birth": date_of_birth,
        "country": country,
        "number": number,
        "phone_number": "$dialcode$number",
        "dialcode": dialcode,
        "country_code": country,
      });
    } catch (e) {
      print("there is an error in Register new user function : $e");
    }
  }

  // logout .
  Future Logout() async {
    try {
      currnet_user = null;
      notifyListeners();
    } catch (e) {
      print("there is an error in logut :$e");
    }
  }

  // get main pets type .
  Future GetMainPetsType() async {
    try {
      mainPetsType =
          await FirebaseFirestore.instance.collection('main_pets').get().then(
                (value) => value.docs
                    .map(
                      (e) => MainPetModel.FromJson(id: e.id, data: e.data()),
                    )
                    .toList(),
              );
      notifyListeners();
      print(
          "main pets type : ${mainPetsType == null ? "null" : mainPetsType!.length}");
    } catch (e) {
      print("there is an error in Get main pets type function :$e");
    }
  }

  // add new pet .
  Future AddNewPet(
      {required String pet_name,
      required String pet_age,
      required String pet_type_id,
      required String pet_gender,
      required XFile pet_image,
      required String pet_type_name}) async {
    try {
      // Get image ref
      Reference imageRef =
          FirebaseStorage.instance.ref("users_pets/${pet_image.name}");
      // upload image .
      await imageRef.putFile(File(pet_image.path));
      print("upload image has been done successfully !");
      // get image url .
      String imageUrl = await imageRef.getDownloadURL();

      //  check if the pet image has url .
      if (currnet_user != null) {
        await FirebaseFirestore.instance.runTransaction(
          (transaction) async {
            // set new pet .
            transaction.set(
                FirebaseFirestore.instance.collection('users_pets').doc(), {
              "pet_name": pet_name.toLowerCase().trim(),
              "user_id": currnet_user!.user_id,
              "user_name": currnet_user!.username,
              "pet_age": pet_age,
              "pet_gender": pet_gender.toLowerCase().trim(),
              "pet_image": imageUrl,
              "pet_type_id": pet_type_id,
              "pet_type_name": pet_type_name,
            });
          },
        );
        //
        print("the new pet has been uploaded successFully !");
      } else {
        print("there is user login!");
      }
    } catch (e) {
      print("there is an error in add new pet function :$e");
    }
  }

  //  Get user Pets .
  Future GetCurrentUserPets() async {
    try {
      // check if the curnet user login .
      if (currnet_user != null) {
        //
        currnet_user_pets = await FirebaseFirestore.instance
            .collection('users_pets')
            .where('user_id', isEqualTo: currnet_user!.user_id)
            .get()
            .then(
              (value) => value.docs
                  .map(
                    (e) => PetModel.FromJson(id: e.id, data: e.data()),
                  )
                  .toList(),
            );

        //
        print(
            "currnet user pets found : ${currnet_user_pets != null ? "${currnet_user_pets!.length}" : "null"}");
        notifyListeners();
      }
    } catch (e) {
      print("there is an error in get user pets function : $e ");
    }
  }

//  clear user pets .
  void ClearUserPets() {
    currnet_user_pets = null;
    notifyListeners();
  }

  // Get Pets For Breed
  Future GetPetsForBreed({
    required String pet_type_id,
  }) async {
    try {
      if (currnet_user != null) {
        breedResult = await FirebaseFirestore.instance
            .collection('users_pets')
            .where('pet_type_id', isEqualTo: pet_type_id)
            .where('user_id', isNotEqualTo: currnet_user!.user_id)
            .get()
            .then(
              (value) => value.docs
                  .map(
                    (e) => PetModel.FromJson(id: e.id, data: e.data()),
                  )
                  .toList(),
            );

        print(
            "The breed result of pets Found : ${breedResult != null ? breedResult!.length : "null"} ");
        notifyListeners();
      }
    } catch (e) {
      print("there is an error in Get Pets for breed function : $e");
    }
  }

  // get owner data for pet you choose to breed .
  Future GetOwnerForCurrnetPet({required String user_id}) async {
    try {
      owner_for_currnet_pet = await FirebaseFirestore.instance
          .collection('users')
          .doc(user_id)
          .get()
          .then(
            (value) => value.exists == true
                ? UserModel.FromJson(user_id: value.id, data: value.data()!)
                : null,
          );

      print(
          "currnet pet's owner id :${owner_for_currnet_pet != null ? owner_for_currnet_pet!.user_id : "null"}");

      notifyListeners();
    } catch (e) {
      print("there is an error in get currnet pets owner function :$e ");
    }
  }

  // get user's pets for currnet owner .
  Future GetPetsForCurrnetOwner() async {
    try {
      if (owner_for_currnet_pet != null) {
        pets_for_currnet_owner = await FirebaseFirestore.instance
            .collection('users_pets')
            .where('user_id', isEqualTo: owner_for_currnet_pet!.user_id)
            .get()
            .then(
              (value) => value.docs
                  .map(
                    (e) => PetModel.FromJson(id: e.id, data: e.data()),
                  )
                  .toList(),
            );

        print(
            "pets for currnet owner found  :${pets_for_currnet_owner != null ? pets_for_currnet_owner!.length : "null"}");

        notifyListeners();
      }
    } catch (e) {
      print("there is an error in get pet for  currnet  owner function :$e ");
    }
  }

  // breed Function .
  Future BreedFunction({
    required PetModel sender_pet_data,
    required PetModel reciver_pet_data,
    required UserModel sender_data,
    required UserModel reciver_data,
  }) async {
    try {
      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          // set new relatetion .
          transaction
              .set(FirebaseFirestore.instance.collection('relations').doc(), {
            'sender_id': sender_data.user_id,
            'recvier_id': reciver_data.user_id,
            "sender_pet": sender_pet_data.ToJson(),
            "reciver_pet": reciver_pet_data.ToJson(),
            "sender_data": sender_data.ToJson(),
            "reciver_data": reciver_data.ToJson(),
            "status": "hold",
            "date": DateTime.now(),
          });
        },
      );

      print("the new relation has been set successfully !");
      //
    } catch (e) {
      print("there is an  error in breed function :$e");
    }
  }

  // get relations .
  Future GetRelationsForCurrentUser() async {
    try {
      if (currnet_user != null) {
        List<RelationModel>? first_list;
        List<RelationModel>? second_list;

        List<RelationModel>? relations =
            await FirebaseFirestore.instance.collection('relations').get().then(
                  (value) => value.docs
                      .map(
                        (e) => RelationModel.FromJson(id: e.id, data: e.data()),
                      )
                      .toList(),
                );

        if (relations != null) {
          first_list = relations
              .where((element) => element.reciver_id == currnet_user!.user_id)
              .toList();

          second_list = relations
              .where((element) => element.sender_id == currnet_user!.user_id)
              .toList();

          List<RelationModel> total = [];

          for (int a = 0; a < first_list.length; a++) {
            total.add(first_list[a]);
          }

          for (int a = 0; a < second_list.length; a++) {
            total.add(second_list[a]);
          }

          currnet_user_relations = total;
          notifyListeners();
        }

        //
        print(
            "currnet user relations found  :${currnet_user_relations == null ? "null" : currnet_user_relations!.length}");
        notifyListeners();
      }
    } catch (e) {
      print("there is an error in  get currnet user relations function : $e");
    }
  }

  // change the relation status .
  Future ChangeTheRelationStatus(
      {required String relation_status, required String relation_id}) async {
    try {
      await FirebaseFirestore.instance
          .collection('relations')
          .doc(relation_id)
          .update({
        "status": relation_status.toLowerCase().trim(),
      });
      print("the relation status has been updated successfully ! ");
    } catch (e) {
      print("there is an error in Change relation status function :$e");
    }
  }

  // get Orders .
  Future GetOrders() async {
    try {
      if (currnet_user != null) {
        // get orders
        orders = await FirebaseFirestore.instance
            .collection('orders')
            .where('user_id', isEqualTo: currnet_user!.user_id)
            .get()
            .then(
              (value) => value.docs
                  .map(
                    (e) => OrderModel.FromJson(order_id: e.id, data: e.data()),
                  )
                  .toList(),
            );

        notifyListeners();
        print("the order found :${orders != null ? orders!.length : "null"} ");
      } else {
        print("no user login ");
      }

      //
    } catch (e) {
      print("there is an error in Get orders function : $e");
    }
  }

  // change order Status .
  Future ChangeOrderStatus(
      {required String order_id, required OrderStatusEnum new_status}) async {
    //
    try {
      //
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(order_id)
          .update({
        "status": new_status == OrderStatusEnum.accept ? 'accept' : 'cancel'
      });
      //
    } catch (e) {
      print("there is an error in change order status functio :$e");
    }
    //
  }

  // delete pets .
  Future DeletePet({required PetModel pet}) async {
    try {
      // delete the documnet for pet .
      await FirebaseFirestore.instance
          .collection('users_pets')
          .doc(pet.pet_id)
          .delete();

      print("pet has been deleted successFully !");
    } catch (e) {
      print("there is an error in delete pet function : $e");
    }
  }
}
