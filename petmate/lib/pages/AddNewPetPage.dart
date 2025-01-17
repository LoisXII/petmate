import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/Widgets/MyTextFormFieldTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/HomePage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class AddNewPetPage extends StatefulWidget {
  const AddNewPetPage({super.key});

  @override
  State<AddNewPetPage> createState() => _AddNewPetPageState();
}

class _AddNewPetPageState extends State<AddNewPetPage> {
  @override
  void initState() {
    context.read<FirebaseProvider>().GetMainPetsType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: mainh * 6.5 / 100,
        title: AutoSizeText(
          MyServices().capitalizeEachWord('new pet'),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: mainh * 0.065 * .4,
              ),
        ),
        backgroundColor: color2,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              // display image choosen
              DisplayPetImage(),

              // add new image for pet button .
              AddImageButton(),

              // pet type dropdownbuttom
              DisplayTypeOfPet(),

              //  pet name .
              DisplayPetNameTextField(),

              // gender .
              DisplayPetGender(),

              //  pet age in months .
              DisplayPetAgeTextField(),

              //add new one button .
              DisplayAddButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayTypeOfPet() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => Consumer<FirebaseProvider>(
          builder: (context, firebase, child) => firebase.mainPetsType != null
              ? Container(
                  margin: EdgeInsets.only(top: mainh * 0.02),
                  width: mainw * .85,
                  height: mainh * .06,
                  decoration: BoxDecoration(
                    color: color3,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) => DropdownButton(
                      hint: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: constraints.maxWidth * 0.02),
                          color: Colors.transparent,
                          child: AutoSizeText(
                            MyServices().capitalizeEachWord("choose pet type"),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: constraints.maxHeight * .35,
                                  fontWeight: FontWeight.bold,
                                ),
                          )),
                      value: functions.pet_type_id,
                      icon: Container(
                        width: constraints.maxWidth * .15,
                        height: constraints.maxHeight,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: LayoutBuilder(
                          builder: (context, constraints) => Transform.scale(
                            scaleX: constraints.maxWidth * 0.020,
                            scaleY: constraints.maxHeight * 0.02,
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      items: firebase.mainPetsType!
                          .map(
                            (e) => DropdownMenuItem(
                              enabled: true,
                              value: e.mainPet_id,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.025),
                                color: color3,
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                child: AutoSizeText(
                                  MyServices().capitalizeEachWord(e.pet_type),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxHeight * .35,
                                      ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      isExpanded: true,
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth * .85 * 0.025),
                      elevation: 10,
                      dropdownColor: color3,
                      borderRadius: BorderRadius.circular(5),
                      underline: const SizedBox(),
                      menuMaxHeight: mainh * 0.30,
                      isDense: false,
                      onChanged: (value) {
                        print("the value is :$value");

                        // get value .
                        if (value != null) {
                          context
                              .read<LocalFunctionProvider>()
                              .GetPetType(id: value);
                        }
                      },
                    ),
                  ),
                )
              : const SizedBox()),
    );
  }

  Widget DisplayPetImage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, function, child) => Container(
        margin: EdgeInsets.only(top: mainh * 0.02),
        width: mainw * .6,
        height: mainh * .25,
        decoration: BoxDecoration(
            color: color2,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: function.image == null
                    ? AssetImage('images/logo-noback.png')
                    : FileImage(File(function.image!.path)),
                fit: BoxFit.fill)),
      ),
    );
  }

  Widget AddImageButton() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return MyButtonTemplate(
        top: mainh * 0.02,
        height: mainh * 0.045,
        radius: 5,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: mainh * 0.045 * .55),
        onPressed: () {
          context.read<LocalFunctionProvider>().ChooseImage();
        },
        backgroundColor: color3,
        text: MyServices().capitalizeEachWord('add image'),
        width: mainw * 0.85);
  }

  Widget DisplayPetNameTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        controller: functions.pet_name_controller,
        top: mainh * 0.02,
        height: mainh * 0.065,
        text: 'pet name ',
        width: mainw * .85,
      ),
    );
  }

  Widget DisplayPetGender() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        //
        MyServices().ShowGenderOptionSheet(
          context: context,
          width: mainw,
          height: mainh * .20,
        );
        //
      },
      child: Container(
        margin: EdgeInsets.only(top: mainh * 0.02),
        width: mainw * .85,
        height: mainh * 0.065,
        padding: EdgeInsets.only(left: mainw * .85 * 0.015),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: color4,
              width: 2,
            )),
        child: Consumer<LocalFunctionProvider>(
          builder: (context, functions, child) => AutoSizeText(
            MyServices().capitalizeEachWord('pet gender : ${functions.gender}'),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontSize: mainh * 0.065 * .335,
                ),
          ),
        ),
      ),
    );
  }

  Widget DisplayPetAgeTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        top: mainh * 0.02,
        height: mainh * 0.065,
        controller: functions.pet_age_controller,
        textInputType: TextInputType.number,
        text: 'pet age (months only) ',
        width: mainw * .85,
      ),
    );
  }

  Widget DisplayAddButton() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Consumer<LocalFunctionProvider>(
        builder: (context, functions, child) => MyButtonTemplate(
            top: mainh * 0.02,
            height: mainh * 0.045,
            backgroundColor: color4,
            radius: 5,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: mainh * 0.045 * .55),
            onPressed: () async {
              // check if the add pet fields stauts true
              AddPetsFieldStatus status = functions.CheckAddPetFieldsStatus();

              // check ..
              // approved
              if (status == AddPetsFieldStatus.approved) {
                // show loading .
                MyServices().ShowLoading(context: context);

                // add pet .
                await firebase.AddNewPet(
                        pet_name: functions.pet_name_controller.text
                            .toLowerCase()
                            .trim(),
                        pet_age: functions.pet_age_controller.text
                            .toLowerCase()
                            .trim(),
                        pet_type_id: functions.pet_type_id!,
                        pet_gender: functions.gender,
                        pet_image: functions.image!,
                        pet_type_name: firebase.mainPetsType!
                            .where(
                              (element) =>
                                  element.mainPet_id == functions.pet_type_id!,
                            )
                            .toList()
                            .first
                            .pet_type)
                    .whenComplete(
                  () {
                    // clear controllers .
                    functions.ClearControllers();

                    // close the loading .
                    MyServices().HideSheet(context: context);

                    // show notificaion
                    MyServices().ShowNotificationSheet(
                        context: context,
                        after_close: () {
                          // going to pets page .
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const HomePage(),
                                type: PageTransitionType.leftToRight),
                          );
                        },
                        type: Notification_Type.success,
                        message: 'pet has been added successfully ');

                    //
                  },
                );

                //
              }
              // not approved
              else {
                // pet gender
                if (status == AddPetsFieldStatus.gender) {
                  // show notificaion
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'please choose gender ');
                }
                //  pet age .
                else if (status == AddPetsFieldStatus.pet_age) {
                  // show notificaion
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'pet age required !');
                }
                // image
                else if (status == AddPetsFieldStatus.image) {
                  // show notificaion
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'please select an image ! ');
                }
                // pet name .
                else if (status == AddPetsFieldStatus.pet_name) {
                  // show notificaion
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'pet name required ! ');
                } else if (status == AddPetsFieldStatus.pet_type_id) {
                  // show notificaion
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'please select pet type ! ');
                } else {
                  // show notificaion
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'something happed ! ');
                }
              }
            },
            text: MyServices().capitalizeEachWord('add pet '),
            width: mainw * 0.85),
      ),
    );
  }
}
