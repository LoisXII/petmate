import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/Widgets/TextWithIConTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/ChatPage.dart';
import 'package:petmate/pages/RelationsPage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class RelationDetailsPage extends StatefulWidget {
  int index;

  RelationDetailsPage({
    super.key,
    required this.index,
  });

  @override
  State<RelationDetailsPage> createState() => _RelationDetailsPageState();
}

class _RelationDetailsPageState extends State<RelationDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: true,
          leading: MyBackButtonTemplate(
            ontap: () {},
          ),
          toolbarHeight: mainh * 6.5 / 100,
          title: AutoSizeText(
            MyServices().capitalizeEachWord("relations"),
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
          decoration: BoxDecoration(
            color: Colors.grey[50],
          ),
          child: Column(
            children: [
              // pets
              Container(
                margin: EdgeInsets.only(top: mainh * 0.02),
                width: mainw * .95,
                height: mainh * .45,
                color: Colors.transparent,
                child: LayoutBuilder(
                  builder: (context, constraints) => Row(
                    children: [
                      // pet one
                      DisplayPetTemplate_one(constraints: constraints),

                      // divider .
                      VerticalDivider(
                        color: Colors.black.withOpacity(0.05),
                        indent: constraints.maxHeight * 0.35,
                        endIndent: constraints.maxHeight * 0.35,
                        width: constraints.maxWidth * 0.05,
                      ),

                      // pet two
                      DisplayPetTemplate_Two(constraints: constraints),
                    ],
                  ),
                ),
              ),

              // controller .
              DisplayController(),
            ],
          ),
        ));
  }

// sender
  Widget DisplayPetTemplate_one({required BoxConstraints constraints}) {
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Container(
        width: constraints.maxWidth * .475,
        height: constraints.maxHeight,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // image .
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * .42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth * .65,
                    height: constraints.maxHeight * .40,
                    child: Image.network(
                      firebase.currnet_user_relations![widget.index].sender_pet
                          .pet_image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // pet name .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.pets_rounded,
                  text: MyServices().capitalizeEachWord(firebase
                      .currnet_user_relations![widget.index]
                      .sender_pet
                      .pet_name)),

              // owner name .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.person,
                  text: MyServices().capitalizeEachWord(firebase
                      .currnet_user_relations![widget.index]
                      .sender_pet
                      .user_name)),

              // Age
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.date_range,
                  text: MyServices().capitalizeEachWord(
                      "${firebase.currnet_user_relations![widget.index].sender_pet.pet_age} months")),

              // country
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.pin_drop,
                  text: MyServices().capitalizeEachWord(firebase
                      .currnet_user_relations![widget.index].sender.country)),

              //
            ],
          ),
        ),
      ),
    );
  }

// reciver .
  Widget DisplayPetTemplate_Two({required BoxConstraints constraints}) {
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Container(
        width: constraints.maxWidth * .475,
        height: constraints.maxHeight,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // image .
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight * .42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth * .65,
                    height: constraints.maxHeight * .40,
                    child: Image.network(
                      firebase.currnet_user_relations![widget.index].reciver_pet
                          .pet_image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // pet name .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.pets_rounded,
                  text: MyServices().capitalizeEachWord(firebase
                      .currnet_user_relations![widget.index]
                      .reciver_pet
                      .pet_name)),

              // owner name .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.person,
                  text: MyServices().capitalizeEachWord(firebase
                      .currnet_user_relations![widget.index].reciver.username)),

              // Age
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.date_range,
                  text: MyServices().capitalizeEachWord(
                      "${firebase.currnet_user_relations![widget.index].reciver_pet.pet_age} months")),

              // country
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  icon: Icons.pin_drop,
                  text: MyServices().capitalizeEachWord(firebase
                      .currnet_user_relations![widget.index].reciver.country)),

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayController() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Container(
        margin: EdgeInsets.only(top: mainh * 0.02),
        width: mainw * .95,
        height: mainh * 0.2,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: [
              // request breed date .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * .235,
                  width: constraints.maxWidth,
                  icon: Icons.date_range,
                  text: MyServices().capitalizeEachWord(DateFormat("yyyy/MM/dd")
                      .format(firebase.currnet_user_relations![widget.index]
                          .relation_date))),

              // Status  .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * .235,
                  width: constraints.maxWidth,
                  icon: Icons.info,
                  text: MyServices().capitalizeEachWord(
                      firebase.currnet_user_relations![widget.index].status)),

              // phone number  .
              TextWithIconTemplate(
                  top: constraints.maxHeight * 0.015,
                  height: constraints.maxHeight * .235,
                  width: constraints.maxWidth,
                  icon: Icons.phone,
                  text: MyServices().capitalizeEachWord(
                      firebase.currnet_user_relations![widget.index].status ==
                              'accept'
                          ? firebase.currnet_user!.user_id ==
                                  firebase.currnet_user_relations![widget.index]
                                      .sender.user_id
                              ? firebase.currnet_user_relations![widget.index]
                                  .reciver.phone_number
                              : firebase.currnet_user_relations![widget.index]
                                  .sender.phone_number
                          : ".....")),

              // Buttons
              SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight * .235,
                child: LayoutBuilder(
                  builder: (context, constraints) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // cancel button
                      Visibility(
                        visible: firebase
                                .currnet_user_relations![widget.index].status ==
                            'hold',
                        child: MyButtonTemplate(
                            top: constraints.maxHeight * 0.015,
                            height: constraints.maxHeight * .85,
                            onPressed: () async {
                              // show loading .
                              MyServices().ShowLoading(context: context);

                              // run funciton .
                              await firebase.ChangeTheRelationStatus(
                                      relation_status: 'cancel',
                                      relation_id: firebase
                                          .currnet_user_relations![widget.index]
                                          .relation_id)
                                  .whenComplete(
                                () {
                                  //
                                  // close the loading .
                                  MyServices().HideSheet(context: context);

                                  // back to relations page .
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                      child: const RelationPage(),
                                      type: PageTransitionType.fade,
                                    ),
                                    (route) => true,
                                  );

                                  //
                                },
                              );
                            },
                            radius: 5,
                            text: MyServices().capitalizeEachWord(firebase
                                        .currnet_user!.user_id ==
                                    firebase
                                        .currnet_user_relations![widget.index]
                                        .sender
                                        .user_id
                                ? 'cancel'
                                : 'reject'),
                            backgroundColor: color3,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * .45,
                                ),
                            width: firebase.currnet_user!.user_id ==
                                    firebase
                                        .currnet_user_relations![widget.index]
                                        .sender
                                        .user_id
                                ? constraints.maxWidth
                                : constraints.maxWidth * .45),
                      ),

                      // accept button
                      Visibility(
                        visible: firebase.currnet_user_relations![widget.index]
                                    .status ==
                                'hold' &&
                            firebase.currnet_user!.user_id !=
                                firebase.currnet_user_relations![widget.index]
                                    .sender.user_id,
                        child: MyButtonTemplate(
                            top: constraints.maxHeight * 0.015,
                            height: constraints.maxHeight * .85,
                            onPressed: () async {
                              // show loading .
                              MyServices().ShowLoading(context: context);

                              // run funciton .
                              await firebase.ChangeTheRelationStatus(
                                      relation_status: 'accept',
                                      relation_id: firebase
                                          .currnet_user_relations![widget.index]
                                          .relation_id)
                                  .whenComplete(
                                () {
                                  //
                                  // close the loading .
                                  MyServices().HideSheet(context: context);

                                  // back to relations page .
                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: const RelationPage(),
                                      type: PageTransitionType.fade,
                                    ),
                                  );

                                  //
                                },
                              );
                            },
                            radius: 5,
                            text: MyServices().capitalizeEachWord('accept'),
                            backgroundColor: color4,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * .45,
                                ),
                            width: constraints.maxWidth * .45),
                      ),

                      // chat button
                      Visibility(
                        visible: firebase
                                .currnet_user_relations![widget.index].status ==
                            'accept',
                        child: MyButtonTemplate(
                            top: constraints.maxHeight * 0.015,
                            height: constraints.maxHeight * .85,
                            onPressed: () async {
                              // goinf to chat
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: ChatPage(
                                          reciver_id: firebase
                                              .currnet_user_relations![
                                                  widget.index]
                                              .reciver_id,
                                          sender_id: firebase
                                              .currnet_user_relations![
                                                  widget.index]
                                              .sender_id),
                                      type: PageTransitionType.leftToRight));
                            },
                            radius: 5,
                            text: MyServices().capitalizeEachWord('chat'),
                            backgroundColor: color4,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * .45,
                                ),
                            width: constraints.maxWidth),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
