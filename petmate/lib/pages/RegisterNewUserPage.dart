import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/Widgets/MyTextFormFieldTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/HomePage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    // get countries .
    context.read<LocalFunctionProvider>().LoadCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: MyBackButtonTemplate(),
        toolbarHeight: mainh * 6.5 / 100,
        title: AutoSizeText(
          "Register",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: mainh * 0.065 * .50,
              ),
        ),
        backgroundColor: color2,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // display user image .
              DisplayImage(),

              // username field .
              FullNameTextField(),

              // email field .
              EmailTextField(),

              // gender
              DisplayGender(),

              // password field .
              PasswordTextField(),

              // date of birth .
              DateOfBirth(),

              // country .
              Country(),

              // phone number
              PhoneNumber(),

              // register button
              RegisterButton(),

              // space .
              SizedBox(
                width: mainw,
                height: mainh * 0.05,
              )

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayImage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => GestureDetector(
        onTap: () {
          context.read<LocalFunctionProvider>().ChooseImage();
        },
        onDoubleTap: () {
          context.read<LocalFunctionProvider>().ClearImage();
        },
        child: Container(
          margin: EdgeInsets.only(top: mainh * 0.02),
          width: mainw * .85,
          height: mainh * .25,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color2,
              image: DecorationImage(
                image: functions.image == null
                    ? const AssetImage('images/no-images.jpg')
                    : FileImage(File(functions.image!.path)),
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }

  Widget DisplayGender() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return
        // gender .
        GestureDetector(
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
        width: mainw * .95,
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
            MyServices().capitalizeEachWord('gender : ${functions.gender}'),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                  fontSize: mainh * 0.065 * .335,
                ),
          ),
        ),
      ),
    );
  }

  Widget RegisterButton() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Consumer<LocalFunctionProvider>(
        builder: (context, functions, child) => MyButtonTemplate(
            top: mainh * 0.02,
            height: mainh * 0.07,
            radius: 5,
            backgroundColor: color3,
            onPressed: () async {
              // check the registeration fields status .
              Registeration_fields_status registeration_fields_status =
                  functions.CheckRegisterationFields();

              print(
                  "the registeration fields status : $registeration_fields_status");
              // check
              if (registeration_fields_status ==
                  Registeration_fields_status.approved) {
                // show loading .
                MyServices().ShowLoading(context: context);

                // run function .
                await firebase.RegisterationUser(
                  image: functions.image!,
                  user_name: functions.fullname_controller_register.text
                      .toLowerCase()
                      .trim(),
                  email: functions.email_controller_register.text
                      .toLowerCase()
                      .trim(),
                  gender: functions.gender.toLowerCase().trim(),
                  password: functions.password_controller_register.text.trim(),
                  date_of_birth: functions.dateTime,
                  country: functions.countryModel!.country_name,
                  number: functions.phoneNumber_controller_register.text.trim(),
                  country_code: functions.countryModel!.country_code,
                  dialcode: functions.countryModel!.country_dialcode,
                ).whenComplete(
                  () {
                    // close the loading .
                    MyServices().HideSheet(context: context);

                    // show notificaion
                    MyServices().ShowNotificationSheet(
                        context: context,
                        after_close: () {
                          // going to home page .
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                                child: const HomePage(),
                                type: PageTransitionType.leftToRight),
                            (route) => true,
                          );

                          // clear controllers .
                          functions.ClearControllers();
                        },
                        type: Notification_Type.success,
                        message:
                            'your account has been created successfully !');
                  },
                );
              }
              // some fields are empty .
              else {
                // user name empty .
                if (registeration_fields_status ==
                    Registeration_fields_status.username) {
                  // show notification
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'full name is empty !');
                }
                // email formate , empty
                if (registeration_fields_status ==
                    Registeration_fields_status.email) {
                  // show notification
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'check email formate must contain (@ | .com)');
                }
                // password
                if (registeration_fields_status ==
                    Registeration_fields_status.password) {
                  // show notification
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'password has to be bigger or equal 8 char');
                }
                // country is empty
                if (registeration_fields_status ==
                    Registeration_fields_status.country) {
                  // show notification
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'please choose your country ');
                }
                // phone number is empty
                if (registeration_fields_status ==
                    Registeration_fields_status.phonenumber) {
                  // show notification
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'phone number is required !');
                }

                // image is null
                if (registeration_fields_status ==
                    Registeration_fields_status.image) {
                  // show notification
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'please add an image !');
                }
              }
            },
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontSize: mainh * 0.07 * .55,
                  fontWeight: FontWeight.bold,
                ),
            text: MyServices().capitalizeEachWord("register"),
            width: mainw * .95),
      ),
    );
  }

  Widget FullNameTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        height: mainh * 0.07,
        top: mainh * 0.02,
        controller: functions.fullname_controller_register,
        text: "full name ",
        width: mainw * .95,
        border_color: color4,
      ),
    );
  }

  Widget PasswordTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        height: mainh * 0.07,
        top: mainh * 0.02,
        controller: functions.password_controller_register,
        text: "password",
        width: mainw * .95,
        border_color: color3,
      ),
    );
  }

  Widget EmailTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        height: mainh * 0.07,
        controller: functions.email_controller_register,
        textInputType: TextInputType.emailAddress,
        top: mainh * 0.02,
        text: "email address ",
        width: mainw * .95,
        border_color: color3,
      ),
    );
  }

  Widget PhoneNumber() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        height: mainh * 0.07,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        textInputType: TextInputType.number,
        top: mainh * 0.02,
        isphonenumber: true,
        text: "phone number",
        controller: functions.phoneNumber_controller_register,
        width: mainw * .95,
        border_color: color4,
      ),
    );
  }

  Widget DateOfBirth() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        MyServices().ShowDatePicker(
          context: context,
          mode: CupertinoDatePickerMode.date,
        );
      },
      child: Consumer<LocalFunctionProvider>(
        builder: (context, localfunction, child) => Container(
          margin: EdgeInsets.only(top: mainh * .02),
          width: mainw * .95,
          height: mainh * 0.07,
          padding: EdgeInsets.symmetric(horizontal: mainw * 0.01),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: color4,
              )),
          child: AutoSizeText(
            MyServices().capitalizeEachWord(
                " date of birth :  ${DateFormat("yyyy-MM-dd").format(localfunction.dateTime)}"),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }

  Widget Country() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          MyServices().ShowCountrySheet(context: context);
        },
        child: Container(
          margin: EdgeInsets.only(top: mainh * .02),
          width: mainw * .95,
          height: mainh * 0.07,
          padding: EdgeInsets.symmetric(horizontal: mainw * 0.01),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: color3,
              )),
          child: AutoSizeText(
            MyServices().capitalizeEachWord(
                'country : ${value.countryModel != null ? "${value.countryModel!.country_name} ${value.countryModel!.country_flag} " : "---"}'),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }

  Widget DisplayAnimation() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      width: mainw,
      height: mainh * .35,
      color: Colors.transparent,
      child: Lottie.asset("lotties/register.json"),
    );
  }
}
