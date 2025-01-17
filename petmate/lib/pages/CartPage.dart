import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:petmate/Widgets/2TextWithIconTemplate.dart';
import 'package:petmate/Widgets/ItemTemplate.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/MyButtonTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/pages/HomePage.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/LocalFunctionProvider.dart';
import 'package:petmate/services/MyServices.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        leading: MyBackButtonTemplate(),
        toolbarHeight: mainh * 0.065,
        title: Consumer<FirebaseProvider>(
          builder: (context, firebase, child) =>
              Consumer<LocalFunctionProvider>(
            builder: (context, functions, child) => AutoSizeText(
              "Cart ${firebase.currnet_user != null ? "- ${functions.cart.length}" : ""}",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.065 * .45,
                  ),
            ),
          ),
        ),
        backgroundColor: color2,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              // dsiplay items in cart  .
              DisplayItemsInCart(),

              // display cart details .
              CartDetails(),

              // order button .
              DisplayOrderButton(),

              // space .
              SizedBox(
                width: mainw,
                height: mainh * 0.05,
              )

              //
            ],
          ),
        ),
      ),
    );
  }

  Widget CartDetails() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<LocalFunctionProvider>(
        builder: (context, functions, child) => functions.cart.isNotEmpty
            ? SizedBox(
                width: mainw * .95,
                child: Column(
                  children: [
                    // item count .
                    TwoTextWithIconTemplate(
                      text1: MyServices().capitalizeEachWord('items count'),
                      text2: '${functions.cart.length}',
                      height: mainh * 0.07,
                      width: mainw * .95,
                      iconData: Icons.numbers,
                      icon_color: color4,
                    ),
                    // taxes
                    TwoTextWithIconTemplate(
                      text1: MyServices().capitalizeEachWord('tax'),
                      text2: '${functions.tax}',
                      height: mainh * 0.07,
                      width: mainw * .95,
                      iconData: Icons.percent,
                      icon_color: color4,
                    ),

                    // delivery fees
                    TwoTextWithIconTemplate(
                      text1: MyServices().capitalizeEachWord('delivery fees'),
                      text2: '${functions.delivery_fees}',
                      height: mainh * 0.07,
                      width: mainw * .95,
                      iconData: Icons.delivery_dining,
                      icon_color: color4,
                    ),

                    // total items price  price .
                    TwoTextWithIconTemplate(
                      text1: MyServices().capitalizeEachWord('items price '),
                      text2: '${functions.items_total_price}',
                      height: mainh * 0.07,
                      width: mainw * .95,
                      iconData: Icons.shopping_cart,
                      icon_color: color4,
                    ),

                    TwoTextWithIconTemplate(
                      text1: MyServices().capitalizeEachWord('total price '),
                      text2: '${functions.cart_total_price}',
                      height: mainh * 0.07,
                      width: mainw * .95,
                      iconData: Icons.credit_card,
                      icon_color: color4,
                    ),
                  ],
                ),
              )
            : const SizedBox());
  }

  Widget DisplayItemsInCart() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Consumer<LocalFunctionProvider>(
          builder: (context, functions, child) =>

              //  cart has items .
              functions.cart.isNotEmpty && firebase.currnet_user != null
                  ? ListView.builder(
                      itemCount: functions.cart.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => UnconstrainedBox(
                          child: ItemTemplate(
                              top: mainh * 0.015,
                              height: mainh * .16,
                              button_lable: 'delete',
                              width: mainw * .95,
                              button: () {
                                // delete item from cart .
                                context
                                    .read<LocalFunctionProvider>()
                                    .DeleteItemFromCart(index: index);

                                // show snackbar for delete proccess .
                                MyServices().ShowSnackBar(
                                    context: context,
                                    message:
                                        'item has been deleted successfully ');
                              },
                              item_id: functions.cart[index].item_id,
                              item_image: functions.cart[index].item_image,
                              item_name: functions.cart[index].item_name,
                              item_price: functions.cart[index].item_price)),
                    )

                  // cart is empty (user loged in successFully ) .
                  : functions.cart.isEmpty && firebase.currnet_user != null
                      ? SizedBox(
                          width: mainw,
                          height: mainh * .55,
                          child: LayoutBuilder(
                            builder: (context, constraints) => Column(
                              children: [
                                // animation
                                Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * .75,
                                  color: Colors.transparent,
                                  child: Lottie.asset('lotties/addtocart.json'),
                                ),

                                // lable .
                                Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight * .25,
                                  color: Colors.transparent,
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    MyServices().capitalizeEachWord(
                                        'no items in cart try to add one !'),
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                          color: color1,
                                          fontSize:
                                              constraints.maxHeight * .25 * .15,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )

                      // when user not login in .
                      : Container(
                          width: mainw,
                          height: mainh * .15,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: AutoSizeText(
                            MyServices().capitalizeEachWord(
                                'please , you have to login or register new user.'),
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: color1,
                                  fontSize: mainh * .15 * .12,
                                ),
                          ),
                        )),
    );
  }

  Widget DisplayOrderButton() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Consumer<LocalFunctionProvider>(
          builder: (context, functions, child) => functions.cart.isNotEmpty &&
                  firebase.currnet_user != null
              ? MyButtonTemplate(
                  height: mainh * .065,
                  onPressed: () async {
                    // show loading .
                    MyServices().ShowLoading(context: context);

                    //  placed an order .
                    await context
                        .read<FirebaseProvider>()
                        .Create_Order(
                            phone_number: firebase.currnet_user!.phone_number,
                            store_id: functions.cart.first.store_id,
                            user_id: firebase.currnet_user!.user_id,
                            user_name: firebase.currnet_user!.username,
                            items: functions.cart,
                            items_total_price:
                                functions.GetTotalPriceForItems(),
                            cart_total_price: functions.GetTotalPriceForCart(),
                            delivery_fees: functions.delivery_fees,
                            tex_fees: functions.tax,
                            status: 'hold')
                        .whenComplete(
                      () {
                        //
                        // clear the carts .
                        functions.clearCart();

                        // going to home page.
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              child: const HomePage(),
                              type: PageTransitionType.leftToRight),
                          (route) => true,
                        );
                        //
                      },
                    );
                  },
                  text: MyServices().capitalizeEachWord('order'),
                  backgroundColor: color3,
                  radius: 5,
                  top: mainh * 0.015,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: mainh * 0.065 * .45,
                      ),
                  width: mainw * .95)
              : const SizedBox()),
    );
  }
}
