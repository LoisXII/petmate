import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/LoadingIndicator.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/PetTemplate_BreedPage.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/OwnerPage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class BreedPage extends StatefulWidget {
  String pet_type_id;
  int index_currnet_user_pets;

  BreedPage({
    super.key,
    required this.pet_type_id,
    required this.index_currnet_user_pets,
  });

  @override
  State<BreedPage> createState() => _BreedPageState();
}

class _BreedPageState extends State<BreedPage> {
  @override
  void initState() {
    context
        .read<FirebaseProvider>()
        .GetPetsForBreed(pet_type_id: widget.pet_type_id);
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
          MyServices().capitalizeEachWord('Breed'),
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
              // pet template .
              DisplayTargetBreedresult(),

              //

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayTargetBreedresult() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.breedResult != null &&
                firebase.breedResult!.isNotEmpty
            ? ListView.builder(
                itemCount: firebase.breedResult!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => UnconstrainedBox(
                  child: PetTemplate_BreedPage(
                    top: mainh * 0.015,
                    ontap: () {
                      //  going to owner for this pet
                      Navigator.push(
                          context,
                          PageTransition(
                              child: OwnerPage(
                                index_currnet_user_pets_sender:
                                    widget.index_currnet_user_pets,
                                owner_id: firebase.breedResult![index].user_id,
                              ),
                              type: PageTransitionType.fade));
                      //
                    },
                    height: mainh * .2,
                    width: mainw * .95,
                    gender: firebase.breedResult![index].gender,
                    pet_owner_name: firebase.breedResult![index].user_name,
                    pet_age: firebase.breedResult![index].pet_age,
                    pet_image: firebase.breedResult![index].pet_image,
                    pet_name: firebase.breedResult![index].pet_name,
                    pet_type_name: firebase.breedResult![index].pet_type_name,
                  ),
                ),
              )
            : firebase.breedResult == null
                ? LoadingIndicator(
                    backgroundcolor: Colors.grey[50],
                  )
                : firebase.breedResult!.isEmpty
                    ? Container(
                        width: mainw,
                        height: mainh * .1,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          MyServices()
                              .capitalizeEachWord('there is no result found !'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: color1,
                                fontSize: mainh * 0.1 * .20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      )
                    : const SizedBox());
  }
}
