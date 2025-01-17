import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/LoadingIndicator.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/RelationDetailsPage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class RelationPage extends StatefulWidget {
  const RelationPage({super.key});

  @override
  State<RelationPage> createState() => _RelationPageState();
}

class _RelationPageState extends State<RelationPage> {
  @override
  void initState() {
    context.read<FirebaseProvider>().GetRelationsForCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: MyBackButtonTemplate(),
          toolbarHeight: mainh * 6.5 / 100,
          title: AutoSizeText(
            MyServices().capitalizeEachWord("relations"),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: mainh * 0.065 * .50,
                ),
          ),
          backgroundColor: color2,
        ),
        body: context.watch<FirebaseProvider>().currnet_user_relations != null
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[50],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // display Relations Pets .
                      DisplayOwnerRelations(),

                      //
                    ],
                  ),
                ),
              )
            : Center(
                child: LoadingIndicator(
                  backgroundcolor: Colors.grey[50],
                ),
              ));
  }

  //
  Widget DisplayOwnerRelations() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase
                        .currnet_user_relations !=
                    null &&
                firebase.currnet_user_relations!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: firebase.currnet_user_relations!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => UnconstrainedBox(
                    child:
                        // template
                        GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: RelationDetailsPage(index: index),
                            type: PageTransitionType.fade));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: mainh * 0.02),
                    width: mainw * .95,
                    height: mainh * .10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        children: [
                          // relation date
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * .45,
                            color: Colors.transparent,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Row(
                                children: [
                                  // icon .
                                  Container(
                                    width: constraints.maxWidth * .15,
                                    height: constraints.maxHeight,
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Transform.scale(
                                      scaleX: constraints.maxWidth * .15 * 0.02,
                                      scaleY: constraints.maxHeight * 0.025,
                                      child: Icon(
                                        Icons.date_range,
                                        color: color1,
                                      ),
                                    ),
                                  ),

                                  // divider .
                                  VerticalDivider(
                                    color: Colors.black.withOpacity(0.10),
                                    width: constraints.maxWidth * 0.05,
                                    endIndent: constraints.maxHeight * 0.10,
                                    indent: constraints.maxHeight * 0.10,
                                  ),

                                  // text.
                                  Container(
                                    width: constraints.maxWidth * .8,
                                    height: constraints.maxHeight,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      MyServices().capitalizeEachWord(
                                          'date : ${DateFormat('yyyy/MM/dd').format(firebase.currnet_user_relations![index].relation_date)}'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            color: color1,
                                            fontSize:
                                                constraints.maxHeight * 0.40,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // divider.
                          Divider(
                            color: Colors.black.withOpacity(0.05),
                            indent: constraints.maxWidth * 0.05,
                            endIndent: constraints.maxWidth * 0.05,
                            thickness: 0.5,
                            height: constraints.maxHeight * 0.10,
                          ),

                          // status .
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * .45,
                            color: Colors.transparent,
                            child: LayoutBuilder(
                              builder: (context, constraints) => Row(
                                children: [
                                  // icon .
                                  Container(
                                    width: constraints.maxWidth * .15,
                                    height: constraints.maxHeight,
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Transform.scale(
                                      scaleX: constraints.maxWidth * .15 * 0.02,
                                      scaleY: constraints.maxHeight * 0.025,
                                      child: Icon(
                                        Icons.info,
                                        color: color1,
                                      ),
                                    ),
                                  ),

                                  // divider .
                                  VerticalDivider(
                                    color: Colors.black.withOpacity(0.10),
                                    width: constraints.maxWidth * 0.05,
                                    endIndent: constraints.maxHeight * 0.10,
                                    indent: constraints.maxHeight * 0.10,
                                  ),

                                  // text.
                                  Container(
                                    width: constraints.maxWidth * .8,
                                    height: constraints.maxHeight,
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      MyServices().capitalizeEachWord(
                                          'status : ${firebase.currnet_user_relations![index].status}'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            color: color1,
                                            fontSize:
                                                constraints.maxHeight * 0.40,
                                          ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          //
                        ],
                      ),
                    ),
                  ),
                )),
              )
            : firebase.currnet_user_relations == null
                ? Center(
                    child: LoadingIndicator(
                      backgroundcolor: Colors.grey[50],
                    ),
                  )
                : firebase.currnet_user_relations!.isEmpty
                    ? Container(
                        width: mainw,
                        height: mainh * .1,
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          MyServices()
                              .capitalizeEachWord('there is relations found !'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: color1,
                                fontSize: mainh * .1 * .20,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      )
                    : const SizedBox());
  }
}
