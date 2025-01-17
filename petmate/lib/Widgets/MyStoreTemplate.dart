import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:petmate/services/MyServices.dart';

class MyStoreTemplate extends StatelessWidget {
  int index;
  String store_id;
  String store_name;
  String? store_image;
  void Function() ontap;

  MyStoreTemplate({
    super.key,
    required this.ontap,
    required this.index,
    required this.store_id,
    this.store_image,
    required this.store_name,
  });

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: EdgeInsets.only(top: mainh * 0.03),
        width: mainw * .95,
        height: mainh * .12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
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
              //
              // space .
              SizedBox(
                width: constraints.maxWidth * 0.025,
                height: constraints.maxHeight,
              ),

              // image of store .
              Container(
                width: constraints.maxWidth * .30,
                height: constraints.maxHeight * .85,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      offset: const Offset(1, 1),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      offset: const Offset(-1, -1),
                      blurRadius: 6,
                    ),
                  ],
                  color: Colors.black,
                  image: DecorationImage(
                      image: store_image != null
                          ? NetworkImage(store_image!)
                          : const AssetImage('images/logo33.png'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              // space .
              SizedBox(
                width: constraints.maxWidth * 0.025,
                height: constraints.maxHeight,
              ),

              // details .
              Container(
                width: constraints.maxWidth * .60,
                height: constraints.maxHeight,
                color: Colors.transparent,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // store name .
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * .60,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          MyServices().capitalizeEachWord(store_name),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxHeight * .30 * .55,
                              ),
                        ),
                      ),

                      // horizental line .
                      Divider(
                        color: Colors.black.withOpacity(0.05),
                        endIndent: constraints.maxWidth * 0.025,
                        indent: constraints.maxWidth * 0.025,
                        thickness: 1,
                        height: constraints.maxHeight * 0.05,
                      ),

                      // rating + rating count
                      Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * .35,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: LayoutBuilder(
                              builder: (context, constraints) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // rating .
                                      Container(
                                        width: constraints.maxWidth * .80,
                                        height: constraints.maxHeight,
                                        color: Colors.transparent,
                                        alignment: Alignment.centerLeft,
                                        child: RatingBarIndicator(
                                          rating: 4,
                                          itemCount: 5,
                                          itemSize: constraints.maxHeight * .60,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ),

                                      // rating count .
                                      Container(
                                        width: constraints.maxWidth * .20,
                                        height: constraints.maxHeight,
                                        color: Colors.transparent,
                                        alignment: Alignment.centerLeft,
                                        child: AutoSizeText(
                                          "(${12 * index + 1})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    constraints.maxHeight * .35,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
