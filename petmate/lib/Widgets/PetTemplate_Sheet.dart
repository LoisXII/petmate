import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petmate/main.dart';
import 'package:petmate/services/MyServices.dart';

class PetTemplate_Sheet extends StatelessWidget {
  double width;
  double height;
  double? top;

  PetTemplate_Sheet({
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(1.5, 1.5),
            blurRadius: 2.5,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(-1.5, -1.5),
            blurRadius: 2.5,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            // image .
            Container(
              width: constraints.maxWidth * .25,
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/f6/cf/a9/f6cfa993a211ba3fd41e212c2ac1abd6.jpg'),
                    fit: BoxFit.fill),
                color: Colors.transparent,
              ),
            ),

            // divider .
            VerticalDivider(
              color: color1.withOpacity(0.15),
              thickness: 0.5,
              endIndent: constraints.maxHeight * 0.05,
              indent: constraints.maxHeight * 0.05,
              width: constraints.maxWidth * .05,
            ),

            // pet details .
            Container(
              width: constraints.maxWidth * .6,
              height: constraints.maxHeight,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    // pet name .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .5,
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.025),
                      child: AutoSizeText(
                        MyServices().capitalizeEachWord('jack'),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color1,
                                  fontSize: constraints.maxHeight * .3 * .05,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),

                    //pet age .
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .5,
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.025),
                      child: AutoSizeText(
                        MyServices().capitalizeEachWord('8 months'),
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color1,
                                  fontSize: constraints.maxHeight * .3 * .05,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    )

                    //
                  ],
                ),
              ),
            ),

            // select option .
            Container(
              width: constraints.maxWidth * .10,
              height: constraints.maxHeight,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Transform.scale(
                  scaleX: constraints.maxWidth * .035,
                  scaleY: constraints.maxHeight * .015,
                  child: CupertinoCheckbox(
                    checkColor: Colors.white,
                    activeColor: color3,
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
