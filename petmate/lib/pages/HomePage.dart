import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/LoadingIndicator.dart';
import 'package:petmate/Widgets/MyDrawerTemplate.dart';
import 'package:petmate/Widgets/MyStoreTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/CartPage.dart';
import 'package:petmate/pages/StorePage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // scaffold key (to open drawer from function ) .
  final GlobalKey<ScaffoldState> _scaffold_key = GlobalKey<ScaffoldState>();
  //
  @override
  void initState() {
    // check login .
    context.read<LocalFunctionProvider>().CheckLoginData(context: context);
    // get stores .
    context.read<FirebaseProvider>().GetStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffold_key,
        appBar: AppBar(
          actions: [
            DisplayCartIcon(),
          ],
          leading: IconButton(
              onPressed: () async {
                context
                    .read<LocalFunctionProvider>()
                    .OpenDrawer(context: context, scaffold_key: _scaffold_key);

                // context.read<LocalFunctionProvider>().ForgetLogin();
              },
              icon: Icon(
                Icons.list,
                color: color1,
                size: mainh * 0.065 * .65,
              )),
          toolbarHeight: mainh * 0.065,
          centerTitle: true,
          title: AutoSizeText(
            "Pet Mate",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: mainh * 0.065 * .50,
                ),
          ),
          backgroundColor: HexColor("#d5d5d5"),
        ),
        backgroundColor: Colors.white,
        drawer:
            context.watch<LocalFunctionProvider>().isLoginDataChecked == true
                ? const MyDrawerTemplate()
                : null,
        body: context.watch<LocalFunctionProvider>().isLoginDataChecked == true
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[50],
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<FirebaseProvider>().GetStores();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // logo  .
                        DisplayLogo(),

                        //  store template.
                        DisplayStores(),

                        // space .
                        SizedBox(
                          width: mainw,
                          height: mainh * .05,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: LoadingIndicator(
                  backgroundcolor: Colors.grey[50],
                ),
              ));
  }

  Widget DisplayCartIcon() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
      builder: (context, functions, child) => Consumer<FirebaseProvider>(
          builder: (context, firebase, child) => Container(
                width: mainw * .15,
                height: mainh * 0.065,
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: LayoutBuilder(
                  builder: (context, constraints) => IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const CartPage(),
                              type: PageTransitionType.leftToRight));
                    },
                    icon: Transform.scale(
                      scaleX: constraints.maxWidth * .020,
                      scaleY: constraints.maxHeight * .020,
                      child: Badge(
                        label: Text(
                          '${functions.cart.length}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.white,
                                fontSize: constraints.maxHeight * 0.2,
                              ),
                        ),
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: color1,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  //  this function display stores where come from server .
  Widget DisplayStores() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
        builder: (context, firebase, child) => firebase.stores != null &&
                firebase.stores!.isNotEmpty
            ? ListView.builder(
                itemCount: firebase.stores!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    // template .
                    UnconstrainedBox(
                        child: MyStoreTemplate(
                  store_id: firebase.stores![index].store_id,
                  ontap: () {
                    //
                    Navigator.push(
                        context,
                        PageTransition(
                            child: StorePage(
                              store_id: firebase.stores![index].store_id,
                            ),
                            type: PageTransitionType.fade));
                    //
                  },
                  store_image: firebase.stores![index].store_image,
                  store_name: firebase.stores![index].store_name,
                  index: index,
                )),
              )
            // waiting indicator to function to be done .
            : firebase.stores == null
                ? Center(child: LoadingIndicator())
                :
                //  when there is no stores in list .
                firebase.stores!.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: mainh * 0.02),
                        width: mainw * .85,
                        height: mainh * .1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: AutoSizeText(
                          MyServices()
                              .capitalizeEachWord('there is no stores found !'),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: color1,
                                fontSize: mainh * .1 * 0.22,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      )
                    : Container(
                        color: Colors.red,
                      ));
  }

  // this function display logo , the image comes from the asset in project folder called images .
  Widget DisplayLogo() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      // margin: EdgeInsets.only(top: mainh * 0.02),
      width: mainw,
      height: mainh * 50 / 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("images/logo-noback1.png"), fit: BoxFit.fill)),
    );
  }
}
