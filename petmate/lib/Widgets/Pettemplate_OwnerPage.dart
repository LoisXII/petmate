import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/services/MyServices.dart';

class PetTemplate_OwnerPage extends StatelessWidget {
  double width;
  double height;
  double? top;
  void Function() breedFunction;
  String pet_name;
  String pet_age;
  String pet_image;
  String gender;
  String pet_type_id;
  String pet_type_name;
  String pet_owner_name;
  String pet_id;
  String user_id;
  int index;

  PetTemplate_OwnerPage({
    super.key,
    required this.index,
    required this.user_id,
    required this.breedFunction,
    required this.height,
    required this.width,
    this.top,
    required this.pet_owner_name,
    required this.pet_id,
    required this.pet_name,
    required this.pet_age,
    required this.gender,
    required this.pet_image,
    required this.pet_type_name,
    required this.pet_type_id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.10),
            offset: const Offset(1, 1),
            blurRadius: 5,
          ),
          BoxShadow(
            color: color1.withOpacity(0.10),
            offset: const Offset(-1, -1),
            blurRadius: 5,
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // pet image .
            Container(
              width: constraints.maxWidth * 0.375,
              height: constraints.maxHeight,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // pet image.
                    Container(
                      width: constraints.maxWidth * .95,
                      height: constraints.maxHeight * .75,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(pet_image), fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                              color: color1.withOpacity(0.10),
                              offset: const Offset(1, 1),
                              blurRadius: 5,
                            ),
                            BoxShadow(
                              color: color1.withOpacity(0.10),
                              offset: const Offset(-1, -1),
                              blurRadius: 5,
                            )
                          ]),
                    ),

                    // request breed .
                    MyButtonTemplate(
                        height: constraints.maxHeight * .15,
                        onPressed: breedFunction,
                        text: "breed",
                        backgroundColor: color3,
                        radius: 5,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                  fontSize: constraints.maxHeight * .2 * .45,
                                ),
                        width: constraints.maxWidth * .95),
                  ],
                ),
              ),
            ),

            // pet details .
            Container(
              width: constraints.maxWidth * .60,
              height: constraints.maxHeight,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // pet name .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.18,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        MyServices().capitalizeEachWord('pet : $pet_name '),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color3,
                                  fontSize: constraints.maxHeight * 0.23 * .35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    // divder .
                    Divider(
                      height: constraints.maxHeight * 0.025,
                      color: color1.withOpacity(0.20),
                      thickness: 0.5,
                      endIndent: constraints.maxWidth * 0.025,
                      indent: constraints.maxWidth * 0.025,
                    ),

                    // pet type .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.18,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        MyServices()
                            .capitalizeEachWord('type : $pet_type_name '),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color4,
                                  fontSize: constraints.maxHeight * 0.23 * .35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),

                    // divder .
                    Divider(
                      height: constraints.maxHeight * 0.025,
                      color: color1.withOpacity(0.20),
                      thickness: 0.5,
                      endIndent: constraints.maxWidth * 0.025,
                      indent: constraints.maxWidth * 0.025,
                    ),

                    // pet age .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.18,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        MyServices()
                            .capitalizeEachWord('age : $pet_age months '),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color3,
                                  fontSize: constraints.maxHeight * 0.23 * .35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),

                    // divder .
                    Divider(
                      height: constraints.maxHeight * 0.025,
                      color: color1.withOpacity(0.20),
                      thickness: 0.5,
                      endIndent: constraints.maxWidth * 0.025,
                      indent: constraints.maxWidth * 0.025,
                    ),

                    // pet owner .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.18,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        MyServices()
                            .capitalizeEachWord('owner : $pet_owner_name '),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color4,
                                  fontSize: constraints.maxHeight * 0.23 * .35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),

                    // divder .
                    Divider(
                      height: constraints.maxHeight * 0.025,
                      color: color1.withOpacity(0.20),
                      thickness: 0.5,
                      endIndent: constraints.maxWidth * 0.025,
                      indent: constraints.maxWidth * 0.025,
                    ),

                    // pet owner .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.18,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        MyServices().capitalizeEachWord('gender : $gender '),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color3,
                                  fontSize: constraints.maxHeight * 0.23 * .35,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
