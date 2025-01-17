import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/LoginPage.dart';
import 'package:petmate/pages/OrdersPage.dart';
import 'package:petmate/pages/PetsPage.dart';
import 'package:petmate/pages/ProfilePage.dart';
import 'package:petmate/pages/RegisterNewUserPage.dart';
import 'package:petmate/pages/RelationsPage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class MyDrawerTemplate extends StatelessWidget {
  const MyDrawerTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Drawer(
      width: mainw * .85,
      surfaceTintColor: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      backgroundColor: Colors.grey[50],
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            // logo .
            DisplayLogo(context: context, constraints: constraints),

            // divider .
            DisplayDivider(constraints: constraints),

            // My Login Button
            MyLoginButton(context: context, constraints: constraints),

            MyRegisterButton(context: context, constraints: constraints),

            // My Profile Button .
            MyProfileButton(context: context, constraints: constraints),

            // My Pets Button
            MyPetsButton(context: context, constraints: constraints),

            // my relation Button
            MyRelationButton(context: context, constraints: constraints),

            MyOrdersButton(context: context, constraints: constraints),

            // My logout Button .
            MyLogOutButton(context: context, constraints: constraints),
          ],
        ),
      ),
    );
  }

  Widget MyOrdersButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user != null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color3,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const OrdersPage(),
                    type: PageTransitionType.fade,
                  ));
            },
            icon: Icons.category,
            text: "orders",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MyRelationButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user != null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color4,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const RelationPage(),
                    type: PageTransitionType.fade,
                  ));
            },
            icon: Icons.compare_arrows_sharp,
            text: "Relations",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MyPetsButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user != null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color3,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const PetsPage(),
                    type: PageTransitionType.fade,
                  ));
            },
            icon: Icons.pets,
            text: "Pets",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MySettingButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user != null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color3,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {},
            icon: Icons.settings,
            text: "Settings",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MyProfileButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user != null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color4,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    child: const ProfilePage(),
                    type: PageTransitionType.fade,
                  ));
            },
            text: "Profile",
            icon: Icons.person,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MyRegisterButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user == null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color4,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const RegisterPage(), type: PageTransitionType.fade));
            },
            text: "Register",
            icon: Icons.person_add,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MyLogOutButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user != null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color4,
            radius: 5,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              // show loading .
              MyServices().ShowLoading(context: context);

              // clear saved login
              context.read<LocalFunctionProvider>().ForgetLogin();

              // logout
              firebase.Logout();

              // close the loading .
              MyServices().HideSheet(context: context);

              //
            },
            text: "Logout",
            icon: Icons.logout,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget MyLoginButton(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Visibility(
        visible: firebase.currnet_user == null,
        child: MyButtonTemplate(
            top: mainh * 0.02,
            backgroundColor: color3,
            radius: 5,
            icon: Icons.login,
            height: constraints.maxHeight * 0.065,
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const LoginPage(), type: PageTransitionType.fade));
            },
            text: "Login",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.065 * .45),
            width: constraints.maxWidth * .95),
      ),
    );
  }

  Widget DisplayDivider({required BoxConstraints constraints}) {
    return Container(
      color: Colors.transparent,
      child: Divider(
        color: color1.withOpacity(.2),
        indent: constraints.maxWidth * 0.05,
        endIndent: constraints.maxWidth * 0.05,
        thickness: 0.5,
        height: constraints.maxHeight * 0.025,
      ),
    );
  }

  Widget DisplayLogo(
      {required BuildContext context, required BoxConstraints constraints}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: mainh * 0.035),
      width: constraints.maxWidth,
      height: constraints.maxHeight * .30,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage("images/logo-noback1.png"),
        ),
      ),
    );
  }
}
