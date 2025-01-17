import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/services/MyServices.dart';

class ItemTemplate extends StatelessWidget {
  double width;
  double height;
  double? top;
  String item_image;
  String item_name;
  String item_price;
  String item_id;
  String button_lable;
  void Function() button;

  ItemTemplate({
    super.key,
    required this.height,
    required this.width,
    required this.button_lable,
    this.top,
    required this.button,
    required this.item_id,
    required this.item_image,
    required this.item_name,
    required this.item_price,
  });

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.05),
            blurRadius: 2.5,
            offset: const Offset(1.5, 1.5),
          ),
          BoxShadow(
            color: color1.withOpacity(0.05),
            blurRadius: 2.5,
            offset: const Offset(-1.5, -1.5),
          )
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            // item details .
            Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight * .62,
              color: Colors.transparent,
              child: LayoutBuilder(
                builder: (context, constraints) => Row(
                  children: [
                    // space .
                    SizedBox(
                      width: constraints.maxWidth * .02,
                      height: constraints.maxHeight,
                    ),

                    // item image .
                    Container(
                      width: constraints.maxWidth * .225,
                      height: constraints.maxHeight * .90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(item_image), fit: BoxFit.fill),
                      ),
                    ),

                    // item name .
                    Container(
                      width: constraints.maxWidth * .58,
                      height: constraints.maxHeight * .90,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * .6 * 0.015,
                      ),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        MyServices().capitalizeEachWord(item_name),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color1,
                                  fontSize: constraints.maxHeight * .9 * .20,
                                ),
                      ),
                    ),

                    // item price .
                    Container(
                      width: constraints.maxWidth * .175,
                      height: constraints.maxHeight * .90,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * .6 * 0.015,
                      ),
                      color: Colors.transparent,
                      child: AutoSizeText(
                        "$item_price JD",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: color1,
                                  fontSize: constraints.maxHeight * .9 * .22,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // divider.
            Divider(
              color: color1.withOpacity(0.05),
              thickness: 1,
              height: constraints.maxHeight * 0.05,
              endIndent: constraints.maxWidth * .02,
              indent: constraints.maxWidth * 0.02,
            ),

            // space .
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.025,
            ),

            // add item to cart .
            MyButtonTemplate(
              height: constraints.maxHeight * .25,
              onPressed: () {
                button();
              },
              backgroundColor: color4,
              radius: 5,
              text: MyServices().capitalizeEachWord(button_lable),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: constraints.maxHeight * .25 * .50),
              width: constraints.maxWidth * .95,
            ),

            // space .
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.055,
            )
          ],
        ),
      ),
    );
  }
}
