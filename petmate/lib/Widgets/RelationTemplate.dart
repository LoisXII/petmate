import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/Widgets/TextWithIConTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/services/MyServices.dart';

class RelationTemplate extends StatelessWidget {
  double width;
  double height;
  double? top;

  RelationTemplate({
    super.key,
    required this.height,
    this.top,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            // pets
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * .635,
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
            Container(
              margin: EdgeInsets.only(top: constraints.maxHeight * 0.015),
              width: constraints.maxWidth,
              height: constraints.maxHeight * .35,
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
                        text: MyServices().capitalizeEachWord(
                            DateFormat("yyyy/MM/dd").format(DateTime.now()))),

                    // Status  .
                    TextWithIconTemplate(
                        top: constraints.maxHeight * 0.015,
                        height: constraints.maxHeight * .235,
                        width: constraints.maxWidth,
                        icon: Icons.info,
                        text: MyServices().capitalizeEachWord('hold')),

                    // phone number  .
                    TextWithIconTemplate(
                        top: constraints.maxHeight * 0.015,
                        height: constraints.maxHeight * .235,
                        width: constraints.maxWidth,
                        icon: Icons.phone,
                        text: MyServices().capitalizeEachWord('+962165853558')),

                    // Button
                    MyButtonTemplate(
                        top: constraints.maxHeight * 0.015,
                        height: constraints.maxHeight * 0.235,
                        onPressed: () {},
                        text: 'chat',
                        backgroundColor: color3,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.235 * .65,
                                ),
                        width: constraints.maxWidth)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget DisplayPetTemplate_one({required BoxConstraints constraints}) {
    return Container(
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
                      'https://i.pinimg.com/564x/87/59/d1/8759d1ac7e2c8c987679f685d7dc367e.jpg'),
                ),
              ),
            ),

            // pet name .
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.pets_rounded,
                text: MyServices().capitalizeEachWord('jack')),

            // owner name .
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.person,
                text: MyServices().capitalizeEachWord('loay aum')),

            // Age
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.date_range,
                text: MyServices().capitalizeEachWord("2 years")),

            // country
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.pin_drop,
                text: MyServices().capitalizeEachWord("jordan")),

            //
          ],
        ),
      ),
    );
  }

  Widget DisplayPetTemplate_Two({required BoxConstraints constraints}) {
    return Container(
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
                      'https://i.pinimg.com/564x/87/59/d1/8759d1ac7e2c8c987679f685d7dc367e.jpg'),
                ),
              ),
            ),

            // pet name .
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.pets_rounded,
                text: MyServices().capitalizeEachWord('jack')),

            // owner name .
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.person,
                text: MyServices().capitalizeEachWord('loay aum')),

            // Age
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.date_range,
                text: MyServices().capitalizeEachWord("2 years")),

            // country
            TextWithIconTemplate(
                top: constraints.maxHeight * 0.015,
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth,
                icon: Icons.pin_drop,
                text: MyServices().capitalizeEachWord("jordan")),

            //
          ],
        ),
      ),
    );
  }
}
