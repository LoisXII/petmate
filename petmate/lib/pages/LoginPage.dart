import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          "Login",
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
        color: Colors.grey[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              // display animation .
              DisplayAnimation(),

              // textfield for email .
              DisplayEmailTextField(),

              // textfield for password .
              DisplayPasswordTextField(),

              // login buttom .
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayAnimation() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return SizedBox(
      width: mainw,
      height: mainh * .35,
      child: Lottie.asset("lotties/login.json"),
    );
  }

  Widget DisplayEmailTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        top: mainh * 0.025,
        controller: functions.email_controller_login,
        height: mainh * 0.07,
        text: MyServices().capitalizeEachWord("email"),
        width: mainw * .95,
      ),
    );
  }

  Widget DisplayPasswordTextField() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => MyTextFormFieldTemplate(
        top: mainh * 0.025,
        controller: functions.password_controller_login,
        height: mainh * 0.07,
        text: MyServices().capitalizeEachWord("password"),
        width: mainw * .95,
      ),
    );
  }

  Widget LoginButton() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => MyButtonTemplate(
            top: mainh * 0.025,
            height: mainh * 0.07,
            onPressed: () async {
              // check login fields status .
              Login_Fields_Status status = functions.CheckLoginFieldsStatus();

              if (status == Login_Fields_Status.approved) {
                // show loading .
                MyServices().ShowLoading(context: context);

                // run
                await firebase.Login(
                        email: functions.email_controller_login.text
                            .toLowerCase()
                            .trim(),
                        password:
                            functions.password_controller_login.text.trim())
                    .then(
                  (value) {
                    print("login status is :$value");

                    // user found  , password match
                    if (value == LoginStatus.user_found_password_match) {
                      // save login .
                      context.read<LocalFunctionProvider>().SaveLogin(
                          email: functions.email_controller_login.text
                              .toLowerCase()
                              .trim(),
                          password:
                              functions.password_controller_login.text.trim());

                      // claer controllers .
                      functions.ClearControllers();

                      // close loading .
                      MyServices().HideSheet(context: context);

                      // show notification.
                      MyServices().ShowNotificationSheet(
                          context: context,
                          after_close: () {
                            // going to home page.
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                  child: const HomePage(),
                                  type: PageTransitionType.fade),
                              (route) => true,
                            );
                          },
                          type: Notification_Type.success,
                          message: 'login success');
                    }
                    //  user found , password not match
                    else if (value ==
                        LoginStatus.user_found_password_no_match) {
                      // close loading .
                      MyServices().HideSheet(context: context);

                      // show notification.
                      MyServices().ShowNotificationSheet(
                          context: context,
                          type: Notification_Type.wronge,
                          message: 'failed , password not match');
                    }
                    // user not found
                    else if (value == LoginStatus.user_not_found) {
                      // close loading .
                      MyServices().HideSheet(context: context);

                      // show notification.
                      MyServices().ShowNotificationSheet(
                          context: context,
                          type: Notification_Type.wronge,
                          message: 'failed , user not found !');
                    }
                    // error .
                    else {
                      // close loading .
                      MyServices().HideSheet(context: context);

                      // show notification.
                      MyServices().ShowNotificationSheet(
                          context: context,
                          type: Notification_Type.wronge,
                          message: 'failed , error occured !');
                    }
                  },
                );
              }
              // some fields are empty .
              else {
                if (status == Login_Fields_Status.email) {
                  // show notification.
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'check email formate must contain (@ | .com)');
                }
                if (status == Login_Fields_Status.password) {
                  // show notification.
                  MyServices().ShowNotificationSheet(
                      context: context,
                      type: Notification_Type.alert,
                      message: 'password must be bigger or equal 8 char ');
                }
              }
            },
            radius: 5,
            foregroundColor: color1,
            backgroundColor: color1,
            text: MyServices().capitalizeEachWord("login"),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontSize: mainh * 0.07 * .55,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
            width: mainw * .95),
      ),
    );
  }
}
