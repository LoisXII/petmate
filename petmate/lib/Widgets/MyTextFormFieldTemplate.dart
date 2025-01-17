import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petmate/main.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class MyTextFormFieldTemplate extends StatelessWidget {
  double width;
  double height;
  String text;
  TextStyle? textStyle;
  Color? border_color;
  TextInputType? textInputType;
  Color? cursorColor;
  TextEditingController? controller;
  double? top;
  List<TextInputFormatter>? inputFormatters;
  bool? isphonenumber;

  MyTextFormFieldTemplate({
    super.key,
    this.isphonenumber,
    this.controller,
    this.cursorColor,
    required this.height,
    this.inputFormatters,
    this.top,
    required this.text,
    this.textInputType,
    this.textStyle,
    required this.width,
    this.border_color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top ?? 0),
      width: width,
      height: height,
      child: CupertinoTextField(
        controller: controller,
        prefix: Consumer<LocalFunctionProvider>(
            builder: (context, functions, child) =>
                functions.countryModel != null &&
                        isphonenumber != null &&
                        isphonenumber != false
                    ? Container(
                        padding: EdgeInsets.only(left: width * .10 * 0.015),
                        width: width * .15,
                        height: height * .75,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: AutoSizeText(
                          functions.countryModel != null
                              ? functions.countryModel!.country_dialcode
                              : "---",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * .75 * .35),
                        ),
                      )
                    : const SizedBox()),
        inputFormatters: inputFormatters,
        placeholder: MyServices().capitalizeEachWord(text),
        placeholderStyle: textStyle ??
            Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                ),
        onTapOutside: (event) {
          //  keyboared hide .
          MyServices().HideKeyboard(context: context);
        },
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: border_color ?? color3,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(1.5, 1.5),
                blurRadius: 5,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(-1.5, -1.5),
                blurRadius: 5,
              ),
            ]),
        cursorColor: cursorColor,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
