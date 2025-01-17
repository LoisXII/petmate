import 'package:flutter/material.dart';
import 'package:petmate/main.dart';

class MyBackButtonTemplate extends StatelessWidget {
  void Function()? ontap;

  MyBackButtonTemplate({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return IconButton(
        onPressed: () {
          //
          Navigator.pop(context);
          // execute the function .
          ontap != null ? ontap!() : null;
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: color1,
          size: mainh * .065 * .55,
        ));
  }
}
