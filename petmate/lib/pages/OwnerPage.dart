import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/LoadingIndicator.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/Pettemplate_OwnerPage.dart';
import 'package:petmate/Widgets/TextWithIConTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/models/PetModel.dart';
import 'package:petmate/models/UserModel.dart';
import 'package:petmate/pages/HomePage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';
import 'package:text_divider/text_divider.dart';

class OwnerPage extends StatefulWidget {
  // owner id for pet (target) you choose
  String owner_id;

  // pet you want to breed with other pet
  int index_currnet_user_pets_sender;

  //
  OwnerPage({
    super.key,
    required this.owner_id,
    required this.index_currnet_user_pets_sender,
  });

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  @override
  void initState() {
    context
        .read<FirebaseProvider>()
        .GetOwnerForCurrnetPet(user_id: widget.owner_id)
        .whenComplete(
      () {
        context.read<FirebaseProvider>().GetPetsForCurrnetOwner();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: MyBackButtonTemplate(),
          centerTitle: true,
          toolbarHeight: mainh * 6.5 / 100,
          title: AutoSizeText(
            MyServices().capitalizeEachWord('owner page'),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: mainh * 0.065 * .45,
                ),
          ),
          backgroundColor: color2,
        ),
        body: context.watch<FirebaseProvider>().owner_for_currnet_pet != null &&
                context.watch<FirebaseProvider>().pets_for_currnet_owner != null
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[50],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // pet image .
                      DisplayImage(),

                      // owner details .
                      DisplayOwnerDetails(),

                      // display textdivider .
                      DisplayTextDivider(),

                      // display pets .
                      DisplayPets(),

                      //
                    ],
                  ),
                ),
              )
            : Center(
                child: LoadingIndicator(
                  backgroundcolor: Colors.grey[50],
                ),
              ));
  }

  Widget DisplayPets() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase
                        .pets_for_currnet_owner !=
                    null &&
                firebase.pets_for_currnet_owner!.isNotEmpty
            ? ListView.builder(
                itemCount: firebase.pets_for_currnet_owner!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => UnconstrainedBox(
                  child: PetTemplate_OwnerPage(
                    top: mainh * 0.02,
                    height: mainh * .21,
                    index: index,
                    pet_age: firebase.pets_for_currnet_owner![index].pet_age,
                    pet_id: firebase.pets_for_currnet_owner![index].pet_id,
                    pet_image:
                        firebase.pets_for_currnet_owner![index].pet_image,
                    pet_name: firebase.pets_for_currnet_owner![index].pet_name,
                    pet_owner_name:
                        firebase.pets_for_currnet_owner![index].user_name,
                    pet_type_id:
                        firebase.pets_for_currnet_owner![index].pet_type_id,
                    pet_type_name:
                        firebase.pets_for_currnet_owner![index].pet_type_name,
                    user_id: firebase.pets_for_currnet_owner![index].user_id,
                    gender: firebase.pets_for_currnet_owner![index].gender,
                    breedFunction: () async {
                      // sender pet .
                      PetModel sender_pet = firebase.currnet_user_pets![
                          widget.index_currnet_user_pets_sender];

                      // user data for sender currnet login .
                      UserModel sender_data = firebase.currnet_user!;

                      // reciver pet.
                      PetModel reciver_pet =
                          firebase.pets_for_currnet_owner![index];

                      // reciver data  .
                      UserModel reciver_data = firebase.owner_for_currnet_pet!;

                      // show loading .
                      MyServices().ShowLoading(context: context);

                      // run function .
                      await context
                          .read<FirebaseProvider>()
                          .BreedFunction(
                            reciver_data: reciver_data,
                            reciver_pet_data: reciver_pet,
                            sender_data: sender_data,
                            sender_pet_data: sender_pet,
                          )
                          .whenComplete(
                        () {
                          // close the loading .
                          MyServices().HideSheet(context: context);

                          // going to home page .
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: const HomePage(),
                                  type: PageTransitionType.fade));
                        },
                      );
                    },
                    width: mainw * .95,
                  ),
                ),
              )
            : firebase.pets_for_currnet_owner == null
                ? Center(
                    child: LoadingIndicator(
                      backgroundcolor: Colors.grey[50],
                    ),
                  )
                : firebase.pets_for_currnet_owner!.isEmpty
                    ? Container(
                        width: mainw,
                        height: mainh * .10,
                        alignment: Alignment.center,
                        color: Colors.grey[50],
                        child: AutoSizeText(
                          MyServices().capitalizeEachWord(
                              'there is no pets found for this user !'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: color1,
                                fontSize: mainh * .1 * .15,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      )
                    : const SizedBox());
  }

  Widget DisplayTextDivider() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: mainh * 0.01),
      height: mainh * 0.04,
      color: Colors.transparent,
      child: TextDivider(
        text: Text(
          MyServices().capitalizeEachWord('pets '),
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: color1,
                fontSize: mainh * 0.04 * .45,
                fontWeight: FontWeight.bold,
              ),
        ),
        thickness: 0.5,
        color: color1.withOpacity(0.2),
      ),
    );
  }

  Widget DisplayImage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.breedResult != null &&
                firebase.owner_for_currnet_pet != null
            ? Container(
                width: mainw,
                height: mainh * .30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                          firebase.owner_for_currnet_pet!.image_url),
                      fit: BoxFit.fill),
                ),
              )
            : const SizedBox());
  }

  Widget DisplayOwnerDetails() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) =>
            firebase.owner_for_currnet_pet != null &&
                    firebase.breedResult != null
                ? Container(
                    margin: EdgeInsets.only(top: mainh * 0.005),
                    width: mainw,
                    height: mainh * .15,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // owner name .
                          TextWithIconTemplate(
                              height: constraints.maxHeight * .30,
                              width: constraints.maxWidth * .95,
                              icon: Icons.label,
                              text: firebase.owner_for_currnet_pet!.username),

                          // owner gender .
                          TextWithIconTemplate(
                              height: constraints.maxHeight * .30,
                              width: constraints.maxWidth * .95,
                              icon: Icons.person,
                              text: firebase.owner_for_currnet_pet!.gender),

                          // owner country .
                          TextWithIconTemplate(
                              height: constraints.maxHeight * .30,
                              width: constraints.maxWidth * .95,
                              icon: Icons.pin_drop,
                              text: firebase.owner_for_currnet_pet!.country),
                        ],
                      ),
                    ),
                  )
                : const SizedBox());
  }
}
