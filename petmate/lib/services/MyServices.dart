import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petmate/Widgets/LoadingPage.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:provider/provider.dart';

enum Notification_Type { success, wronge, alert }

class MyServices {
  // show loading .
  void ShowLoading({required BuildContext context}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const LoadingPage(),
    );
  }

  // show snackbar .
  void ShowSnackBar({
    required BuildContext context,
    required String message,
    Color? background,
    width,
    height,
  }) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    // snackbar message .
    final SnackBar snackBar = SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: background ?? color3,
        content: Container(
          width: width ?? mainw,
          height: height ?? mainh * .05,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: AutoSizeText(
            MyServices().capitalizeEachWord(message),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ));

    // show snackbar .
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // show Country Sheet .
  void ShowCountrySheet({
    required BuildContext context,
  }) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Consumer<LocalFunctionProvider>(
              builder: (context, functions, child) => Container(
                width: mainw,
                height: mainh * .85,
                color: Colors.grey[50],
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // lable .
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.08,
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              capitalizeEachWord('Select country '),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color: color1,
                                    fontSize:
                                        constraints.maxHeight * 0.08 * .35,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),

                          // divider .
                          Divider(
                            color: color1.withOpacity(0.10),
                            endIndent: constraints.maxWidth * 0.05,
                            indent: constraints.maxWidth * 0.05,
                            height: constraints.maxHeight * 0.05,
                            thickness: 0.5,
                          ),

                          // display the countries .
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: functions.Countries != null
                                ? functions.Countries!.length
                                : 0,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                functions.GetCountry(index);
                                // close the sheet .
                                HideSheet(context: context);
                              },
                              child: UnconstrainedBox(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: constraints.maxHeight * 0.02),
                                  width: constraints.maxWidth * .95,
                                  height: constraints.maxHeight * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color1.withOpacity(0.05),
                                          offset: const Offset(1, 1),
                                          blurRadius: 5,
                                        ),
                                        BoxShadow(
                                          color: color1.withOpacity(0.05),
                                          offset: const Offset(-1, -1),
                                          blurRadius: 5,
                                        ),
                                      ]),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) => Row(
                                      children: [
                                        // flag .
                                        Container(
                                          width: constraints.maxWidth * .15,
                                          height: constraints.maxHeight,
                                          color: Colors.transparent,
                                          // padding: EdgeInsets.only(
                                          //   left:
                                          //       constraints.maxWidth * .3 * 0.015,
                                          // ),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            functions
                                                .Countries![index].country_flag,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                  color: color1,
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.35,
                                                ),
                                          ),
                                        ),

                                        // name .
                                        Container(
                                          width: constraints.maxWidth * .70,
                                          height: constraints.maxHeight,
                                          color: Colors.transparent,
                                          // padding: EdgeInsets.only(
                                          //   left:
                                          //       constraints.maxWidth * .3 * 0.015,
                                          // ),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            functions
                                                .Countries![index].country_name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                  color: color1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.35,
                                                ),
                                          ),
                                        ),

                                        // country code .
                                        Container(
                                          width: constraints.maxWidth * .15,
                                          height: constraints.maxHeight,
                                          color: Colors.transparent,
                                          // padding: EdgeInsets.only(
                                          //   left:
                                          //       constraints.maxWidth * .3 * 0.015,
                                          // ),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            functions
                                                .Countries![index].country_code,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge!
                                                .copyWith(
                                                  color: color1,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          0.35,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  // show gender option sheet
  void ShowGenderOptionSheet({
    required BuildContext context,
    double? width,
    double? height,
  }) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    // show .
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: true,
        builder: (context) => Container(
              width: width ?? mainw,
              height: height ?? mainh * .2,
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Material(
                color: Colors.transparent,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // lable .
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * .2,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: AutoSizeText(
                          "Select Gender ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * .2 * .55),
                        ),
                      ),

                      // divider .
                      Divider(
                        color: color1.withOpacity(0.15),
                        thickness: 0.5,
                        endIndent: constraints.maxWidth * 0.05,
                        indent: constraints.maxWidth * 0.05,
                        height: constraints.maxHeight * 0.05,
                      ),

                      // gender picker .
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * .70,
                        color: Colors.grey[50],
                        child: LayoutBuilder(
                          builder: (context, constraints) => CupertinoPicker(
                              itemExtent: constraints.maxHeight * .35,
                              onSelectedItemChanged: (value) {
                                print("the gender choosen is : $value");
                                // get gender function .
                                context
                                    .read<LocalFunctionProvider>()
                                    .GetGender(value);
                              },
                              children: [
                                // male
                                Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * .35,
                                  color: Colors.grey[50],
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    MyServices().capitalizeEachWord('male'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: color1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxHeight *
                                              0.35 *
                                              .40,
                                        ),
                                  ),
                                ),
                                // female
                                Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * .35,
                                  color: Colors.grey[50],
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    MyServices().capitalizeEachWord('female'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: color1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: constraints.maxHeight *
                                              0.35 *
                                              .40,
                                        ),
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  // yes no questions .
  void ShowYesNODialog({
    required BuildContext context,
    required void Function() yes,
    required void Function() no,
    required String question,
    TextStyle? style,
    double? width,
    double? height,
  }) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    // show .
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (context) => Container(
              width: width ?? mainw,
              height: height ?? mainh * .2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Material(
                color: Colors.transparent,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      // question .
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * .60,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: AutoSizeText(
                          MyServices().capitalizeEachWord(question),
                          style: style ??
                              Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color: color1,
                                    fontSize: constraints.maxHeight * .6 * .15,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),

                      // divider .
                      Divider(
                        color: color1.withOpacity(0.10),
                        indent: constraints.maxWidth * 0.02,
                        endIndent: constraints.maxWidth * 0.02,
                        thickness: 0.5,
                        height: constraints.maxHeight * 0.05,
                      ),

                      // options
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * .30,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // yes  .
                              MyButtonTemplate(
                                  height: constraints.maxHeight * .85,
                                  onPressed: yes,
                                  backgroundColor: color3,
                                  radius: 5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            constraints.maxHeight * .9 * .45,
                                      ),
                                  text: MyServices().capitalizeEachWord('yes'),
                                  width: constraints.maxWidth * .40),

                              // no .
                              MyButtonTemplate(
                                  height: constraints.maxHeight * .85,
                                  onPressed: no,
                                  backgroundColor: color4,
                                  radius: 5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            constraints.maxHeight * .9 * .45,
                                      ),
                                  text: MyServices().capitalizeEachWord('no'),
                                  width: constraints.maxWidth * .40)
                            ],
                          ),
                        ),
                      ),

                      // space .
                      SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.05,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  // Show Notification Sheet .
  void ShowNotificationSheet({
    required BuildContext context,
    required Notification_Type type,
    required String message,
    void Function()? after_close,
  }) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
        child: Container(
          width: mainw,
          height: mainh * 30 / 100,
          color: Colors.white,
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                //  animation .
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * .4,
                  child: Lottie.asset(type == Notification_Type.success
                      ? "lotties/success.json"
                      : type == Notification_Type.wronge
                          ? "lotties/wronge.json"
                          : type == Notification_Type.alert
                              ? "lotties/alert.json"
                              : ""),
                ),

                // notification status.
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * .20,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    type == Notification_Type.success
                        ? capitalizeEachWord("success")
                        : type == Notification_Type.wronge
                            ? capitalizeEachWord("wronge")
                            : type == Notification_Type.alert
                                ? capitalizeEachWord("alert")
                                : "",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: color1,
                          fontSize: constraints.maxHeight * .2 * .45,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),

                // message .
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * .4,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    capitalizeEachWord(message),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: color1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: constraints.maxHeight * .4 * .15,
                        ),
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).whenComplete(
      () {
        after_close != null ? after_close() : null;
      },
    );

    //
  }

  // Show Date Picker .
  void ShowDatePicker(
      {required BuildContext context, required CupertinoDatePickerMode mode}) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
              width: mainw,
              height: mainh * .40,
              color: Colors.white,
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // date picker .
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .80,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (value) {
                          // get the new date and time .
                          context
                              .read<LocalFunctionProvider>()
                              .GetDateTime(value);
                        },
                        mode: mode,
                      ),
                    ),

                    // done button .
                    MyButtonTemplate(
                        height: constraints.maxHeight * .15,
                        icon: Icons.done,
                        backgroundColor: color1,
                        icon_color: Colors.white,
                        onPressed: () {
                          //
                          MyServices().HideSheet(context: context);
                          //
                        },
                        radius: 5,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.white,
                                  fontSize: constraints.maxHeight * .2 * .35,
                                ),
                        text: MyServices().capitalizeEachWord("done"),
                        width: constraints.maxWidth * .90),

                    // space .
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * .05,
                    )
                  ],
                ),
              ),
            ));
  }

  // capitilization .
  String capitalizeEachWord(String input) {
    // Split the string into words
    List<String> words = input.split(' ');

    // Capitalize the first letter of each word
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word; // Handle empty strings
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join the words back into a single string
    return capitalizedWords.join(' ');
  }

  // hide Keyboard .
  void HideKeyboard({required BuildContext context}) {
    //
    FocusScope.of(context).unfocus();
    //
  }

  // hide Sheet or alert Dialog .
  void HideSheet({required BuildContext context}) {
    //
    Navigator.pop(context);
    //
  }
}
