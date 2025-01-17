import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/LoadingIndicator.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/PetTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/AddNewPetPage.dart';
import 'package:petmate/pages/BreedPage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  void initState() {
    //  get main pets type .
    context.read<FirebaseProvider>().GetMainPetsType();

    //  get pets .
    context.read<FirebaseProvider>().GetCurrentUserPets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: MyBackButtonTemplate(
          ontap: () {
            context.read<FirebaseProvider>().ClearUserPets();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const AddNewPetPage(),
                        type: PageTransitionType.rightToLeft));
              },
              icon: Icon(
                Icons.add,
                color: color1,
                size: mainh * .065 * .55,
              ))
        ],
        toolbarHeight: mainh * 6.5 / 100,
        title: Consumer<FirebaseProvider>(
          builder: (context, firebase, child) => AutoSizeText(
            MyServices().capitalizeEachWord(
                'My Pets ${firebase.currnet_user_pets != null ? firebase.currnet_user_pets!.length : "..."}'),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: mainh * 0.065 * .50,
                ),
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
              //
              // Pets Template.
              DisplayPets(),

              //
            ],
          ),
        ),
      ),
    );
  }

  // function to display the pets .
  Widget DisplayPets() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.currnet_user_pets !=
                    null &&
                firebase.currnet_user_pets!.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(top: mainh * 0.05),
                width: mainw,
                height: mainh * .75,
                child: LayoutBuilder(
                  builder: (context, constraints) => ListView.builder(
                    itemCount: firebase.currnet_user_pets!.length,
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => UnconstrainedBox(
                        child: Padding(
                      padding: EdgeInsets.only(
                        left: constraints.maxWidth * .075,
                        right: constraints.maxWidth * .075,
                      ),
                      child: PetTemplate(
                        width: constraints.maxWidth * .85,
                        breedFunction: () {
                          // going to breed page .
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: BreedPage(
                                    pet_type_id: firebase
                                        .currnet_user_pets![index].pet_type_id,
                                    index_currnet_user_pets: index),
                              ));
                        },
                        deleteFunction: () async {
                          // show loading
                          MyServices().ShowLoading(context: context);

                          // run function .
                          await context
                              .read<FirebaseProvider>()
                              .DeletePet(
                                  pet: firebase.currnet_user_pets![index])
                              .whenComplete(
                            () async {
                              // update the pets .
                              await context
                                  .read<FirebaseProvider>()
                                  .GetCurrentUserPets();

                              // close the loading .
                              MyServices().HideSheet(context: context);

                              //
                            },
                          );
                        },
                        pet_id: firebase.currnet_user_pets![index].pet_id,
                        height: constraints.maxHeight,
                        pet_age: firebase.currnet_user_pets![index].pet_age,
                        pet_image: firebase.currnet_user_pets![index].pet_image,
                        pet_name: firebase.currnet_user_pets![index].pet_name,
                        pet_type_name:
                            firebase.currnet_user_pets![index].pet_type_name,
                        gender: firebase.currnet_user_pets![index].gender,
                      ),
                    )),
                  ),
                ),
              )
            : firebase.currnet_user_pets == null
                ? LoadingIndicator(
                    backgroundcolor: Colors.grey[50],
                  )
                : firebase.currnet_user_pets!.isEmpty
                    ? Container(
                        width: mainw,
                        height: mainh * .15,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: AutoSizeText(
                          MyServices().capitalizeEachWord(
                              'There is no pets found try to add one '),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: color1,
                                fontSize: mainh * .15 * .15,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      )
                    : const SizedBox());
  }
}
