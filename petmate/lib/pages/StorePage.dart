import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:petmate/Widgets/ItemTemplate.dart';
import 'package:petmate/Widgets/LoadingIndicator.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  String store_id;
  StorePage({
    super.key,
    required this.store_id,
  });

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    // get single store date .
    context
        .read<FirebaseProvider>()
        .GetSingleStore(store_id: widget.store_id)
        .whenComplete(
      () {
        // get items .
        context.read<FirebaseProvider>().GetItems(store_id: widget.store_id);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: MyBackButtonTemplate(
            ontap: () {
              context.read<FirebaseProvider>().clear();
            },
          ),
          toolbarHeight: mainh * 6.5 / 100,
          title: Consumer<FirebaseProvider>(
            builder: (context, firebase, child) => AutoSizeText(
              MyServices().capitalizeEachWord(firebase.currnet_store == null
                  ? '... store'
                  : "${firebase.currnet_store!.store_name} store"),
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.065 * .35,
                  ),
            ),
          ),
          backgroundColor: color2,
        ),
        body: context.watch<FirebaseProvider>().currnet_store != null
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[50],
                child: RefreshIndicator(
                  onRefresh: () async {
                    // get single store date .
                    context
                        .read<FirebaseProvider>()
                        .GetSingleStore(store_id: widget.store_id)
                        .whenComplete(
                      () {
                        // get items .
                        context
                            .read<FirebaseProvider>()
                            .GetItems(store_id: widget.store_id);
                      },
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // sore image .
                        DisplayStoreImage(),

                        // store name .
                        DisplayStoreName(),

                        // Display Items  .
                        DisplayItems(),
                      ],
                    ),
                  ),
                ),
              )
            // loading page .
            : Center(
                child: LoadingIndicator(
                  backgroundcolor: Colors.grey[50],
                ),
              ));
  }

  Widget DisplayStoreImage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Container(
        width: mainw,
        height: mainh * .35,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: firebase.currnet_store != null &&
                  firebase.currnet_store!.store_image != null
              ? NetworkImage(firebase.currnet_store!.store_image!)
              : const AssetImage('images/logo-noback.png'),
          fit: BoxFit.fill,
        )),
      ),
    );
  }

  Widget DisplayStoreName() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Container(
        width: mainw,
        height: mainh * 0.09,
        decoration: BoxDecoration(
          color: color4,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              //

              //  store name
              Container(
                width: constraints.maxWidth * .55,
                height: constraints.maxHeight,
                alignment: Alignment.centerLeft,
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: mainw * 0.02,
                ),
                child: AutoSizeText(
                  MyServices().capitalizeEachWord(firebase.currnet_store != null
                      ? "${firebase.currnet_store!.store_name} store "
                      : "... store "),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: mainh * 0.09 * .25,
                      ),
                ),
              ),

              // rating .
              Container(
                width: constraints.maxWidth * .45,
                height: constraints.maxHeight,
                alignment: Alignment.center,
                child: LayoutBuilder(
                  builder: (context, constraints) => Row(
                    children: [
                      // rating .
                      Container(
                        width: constraints.maxWidth * .7,
                        height: constraints.maxHeight,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: RatingBarIndicator(
                          unratedColor: Colors.white,
                          rating: 4,
                          itemSize: constraints.maxHeight * 0.25,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      ),

                      // rating count  .
                      Container(
                        width: constraints.maxWidth * .30,
                        height: constraints.maxHeight,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: AutoSizeText(
                          MyServices().capitalizeEachWord('(${145})'),
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxHeight * 0.20,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              )

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget DisplayItems() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.currnet_store != null &&
                firebase.items != null &&
                firebase.items!.isNotEmpty
            ? ListView.builder(
                itemCount: firebase.items!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => UnconstrainedBox(
                      child: ItemTemplate(
                        button_lable: "add to cart ",
                        height: mainh * .15,
                        width: mainw * .95,
                        top: mainh * 0.025,
                        button: () {
                          // add item to cart .
                          context
                              .read<LocalFunctionProvider>()
                              .AddItemToCart(item: firebase.items![index]);

                          // show snackbar .
                          MyServices().ShowSnackBar(
                              context: context,
                              message:
                                  'item has been added to cart successfully !');
                        },
                        item_id: firebase.items![index].item_id,
                        item_image: firebase.items![index].item_image,
                        item_name: firebase.items![index].item_name,
                        item_price: firebase.items![index].item_price,
                      ),
                    ))
            : firebase.items == null
                ? Center(
                    child: LoadingIndicator(
                      backgroundcolor: Colors.grey[50],
                    ),
                  )
                : firebase.items!.isEmpty
                    ? Container(
                        width: mainw,
                        height: mainh * .1,
                        alignment: Alignment.center,
                        color: Colors.grey[50],
                        child: AutoSizeText(
                          MyServices()
                              .capitalizeEachWord('there is no items found !'),
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
                    :

                    //
                    Container(
                        width: mainw * .85,
                        height: mainh * .1,
                        alignment: Alignment.center,
                        color: Colors.red,
                        child: AutoSizeText(
                          MyServices().capitalizeEachWord('something error !'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: color1,
                                fontSize: mainh * .1 * .35,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ));
  }
}
