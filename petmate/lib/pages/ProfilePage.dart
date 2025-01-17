import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmate/Widgets/TextWithIConTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: mainh * 6.5 / 100,
        title: AutoSizeText(
          MyServices().capitalizeEachWord('profile'),
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
              // owner image .
              DisplayProfileImage(),

              // username .
              DisplayUserName(),

              // email .
              DisplayEmail(),

              // date of birth .
              DisplayDateOFBirth(),
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayProfileImage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.currnet_user != null
            ? Container(
                margin: EdgeInsets.only(top: mainh * 0.015),
                width: mainw * .60,
                height: mainh * .25,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(firebase.currnet_user!.image_url),
                        fit: BoxFit.fill)),
              )
            : const SizedBox());
  }

  DisplayUserName() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, value, child) => value.currnet_user != null
            ? TextWithIconTemplate(
                height: mainh * 0.07,
                top: mainh * 0.02,
                icon: Icons.person,
                width: mainw * .95,
                text: value.currnet_user!.username,
              )
            : const SizedBox());
  }

  DisplayEmail() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.currnet_user != null
            ? TextWithIconTemplate(
                height: mainh * 0.07,
                top: mainh * 0.02,
                icon: Icons.email,
                width: mainw * .95,
                text: firebase.currnet_user!.email,
              )
            : const SizedBox());
  }

  DisplayDateOFBirth() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.currnet_user != null
            ? TextWithIconTemplate(
                height: mainh * 0.07,
                top: mainh * 0.02,
                icon: Icons.date_range_outlined,
                width: mainw * .95,
                text: DateFormat("yyyy-MM-dd")
                    .format(firebase.currnet_user!.date_of_birth),
              )
            : const SizedBox());
  }
}
