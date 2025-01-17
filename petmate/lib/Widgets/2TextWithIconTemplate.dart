import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petmate/main.dart';

class TwoTextWithIconTemplate extends StatelessWidget {
  double width;
  double height;
  Color? backgroundcolor;
  Color? icon_color;
  String text1;
  String text2;
  TextStyle? style;
  IconData? iconData;
  TextStyle? symbol_style;

  TwoTextWithIconTemplate({
    super.key,
    this.style,
    this.symbol_style,
    this.iconData,
    required this.text1,
    required this.text2,
    this.backgroundcolor,
    this.icon_color,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundcolor,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          children: [
            // icon .
            Container(
              width: constraints.maxWidth * .15,
              height: constraints.maxHeight,
              color: Colors.transparent,
              child: Transform.scale(
                scaleX: constraints.maxWidth * 0.0025,
                scaleY: constraints.maxHeight * 0.015,
                child: Icon(
                  iconData ?? Icons.person,
                  color: icon_color,
                ),
              ),
            ),

            // divider .
            VerticalDivider(
              indent: constraints.maxHeight * 0.20,
              endIndent: constraints.maxHeight * 0.20,
              thickness: 0.5,
              width: constraints.maxWidth * 0.05,
              color: Colors.black.withOpacity(0.15),
            ),

            // text 1 .
            Container(
              width: constraints.maxWidth * .375,
              height: constraints.maxHeight,
              padding: EdgeInsets.only(left: constraints.maxWidth * 0.01),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: AutoSizeText(
                  text1,
                  style: style ??
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: color1,
                            fontSize: constraints.maxHeight * .25,
                          ),
                ),
              ),
            ),

            // symbol :
            Container(
              width: constraints.maxWidth * .05,
              height: constraints.maxHeight,
              alignment: Alignment.center,
              color: Colors.transparent,
              child: AutoSizeText(
                ":",
                style: symbol_style ??
                    Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: color1,
                          fontSize: constraints.maxHeight * .25,
                        ),
              ),
            ),

            // text 2 .
            Container(
              width: constraints.maxWidth * .375,
              height: constraints.maxHeight,
              padding: EdgeInsets.only(left: constraints.maxWidth * 0.01),
              color: Colors.transparent,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: AutoSizeText(
                  text2,
                  style: style ??
                      Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: color1,
                            fontSize: constraints.maxHeight * .25,
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
