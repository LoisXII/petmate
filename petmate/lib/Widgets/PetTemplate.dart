import 'package:flutter/material.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/Widgets/TextWithIConTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/services/MyServices.dart';

class PetTemplate extends StatelessWidget {
  double width;
  double height;
  double? top;
  String pet_name;
  String pet_age;
  String pet_image;
  String gender;
  String pet_type_name;
  void Function() breedFunction;
  void Function() deleteFunction;

  String pet_id;

  PetTemplate({
    super.key,
    required this.breedFunction,
    required this.deleteFunction,
    required this.width,
    required this.pet_id,
    required this.pet_name,
    required this.pet_age,
    required this.gender,
    required this.pet_image,
    required this.pet_type_name,
    required this.height,
    this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      width: width,
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // pets image
            Container(
              width: constraints.maxWidth * .65,
              height: constraints.maxHeight * .35,
              decoration: BoxDecoration(
                  color: color2,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      pet_image,
                    ),
                    fit: BoxFit.fill,
                  )),
            ),

            // pets name  .
            TextWithIconTemplate(
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: color1,
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxHeight * .1 * .30,
                    ),
                width: constraints.maxWidth,
                height: constraints.maxHeight * .10,
                icon: Icons.pets,
                text: MyServices().capitalizeEachWord(pet_name)),

            // pets gender   .
            TextWithIconTemplate(
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: color1,
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxHeight * .1 * .30,
                    ),
                width: constraints.maxWidth,
                height: constraints.maxHeight * .1,
                icon: Icons.male,
                text: MyServices().capitalizeEachWord(gender)),

            // pets age    .
            TextWithIconTemplate(
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: color1,
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxHeight * .1 * .30,
                    ),
                width: constraints.maxWidth,
                height: constraints.maxHeight * .1,
                icon: Icons.label,
                text: MyServices().capitalizeEachWord("$pet_age months")),

            // pets type    .
            TextWithIconTemplate(
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: color1,
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.maxHeight * .1 * .30,
                    ),
                width: constraints.maxWidth,
                height: constraints.maxHeight * .1,
                icon: Icons.info,
                text: MyServices().capitalizeEachWord(pet_type_name)),

            // breed the pet
            MyButtonTemplate(
                height: constraints.maxHeight * .07,
                backgroundColor: color4,
                onPressed: () {
                  breedFunction();
                },
                radius: 5,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: constraints.maxHeight * 0.07 * .65,
                      fontWeight: FontWeight.bold,
                    ),
                text: MyServices().capitalizeEachWord('breed'),
                width: constraints.maxWidth),

            // delete the pet
            MyButtonTemplate(
                height: constraints.maxHeight * .07,
                backgroundColor: color3,
                onPressed: () {
                  deleteFunction();
                },
                radius: 5,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: constraints.maxHeight * 0.07 * .65,
                      fontWeight: FontWeight.bold,
                    ),
                text: MyServices().capitalizeEachWord('delete'),
                width: constraints.maxWidth)
          ],
        ),
      ),
    );
  }
}
