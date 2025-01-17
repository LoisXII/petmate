import 'package:flutter/material.dart';
import 'package:petmate/Widgets/2TextWithIconTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/models/ItemModel.dart';
import 'package:petmate/services/MyServices.dart';

class OrderTemplate extends StatelessWidget {
  final String order_id;
  final double cart_total_price;
  final double delivery_fees;
  final double item_total_price;
  final List<ItemModel> items;
  final String order_date;
  final String status;
  final String store_id;
  final double tax_fees;
  final String user_id;
  final String user_name;
  final double? top;
  final String phone_number;

  const OrderTemplate({
    super.key,
    this.top,
    required this.user_name,
    required this.phone_number,
    required this.status,
    required this.order_date,
    required this.store_id,
    required this.user_id,
    required this.items,
    required this.order_id,
    required this.cart_total_price,
    required this.delivery_fees,
    required this.item_total_price,
    required this.tax_fees,
  });

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: top ?? 00),
      width: mainw * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: color1,
          width: 2.5,
        ),
      ),
      child: Column(
        children: [
          // customer name .
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('customer'),
              text2: MyServices().capitalizeEachWord(user_name),
              icon_color: color3,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // customer phone_number  .
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('phone number'),
              text2: MyServices().capitalizeEachWord(phone_number),
              icon_color: color3,
              iconData: Icons.phone,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // date of order .
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('order date'),
              text2: order_date,
              icon_color: color3,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              iconData: Icons.date_range_outlined,
              height: mainh * 0.07,
              width: mainw * .95),

          // status .
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('status'),
              text2: MyServices().capitalizeEachWord(status),
              iconData: Icons.info,
              icon_color: color3,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // items price  .
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('items price'),
              text2: MyServices().capitalizeEachWord('$item_total_price jd'),
              icon_color: color3,
              iconData: Icons.price_change,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // items
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) => TwoTextWithIconTemplate(
                height: mainh * 0.07,
                width: mainw * .95,
                iconData: Icons.numbers,
                icon_color: color3,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: color1,
                      fontWeight: FontWeight.bold,
                      fontSize: mainh * 0.07 * .25,
                    ),
                text2: '${items[index].item_price} JD',
                text1: items[index].item_name),
          ),

          // deivery fees
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('delivery fees '),
              text2: MyServices().capitalizeEachWord('$delivery_fees jd'),
              icon_color: color3,
              iconData: Icons.price_change,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // taxes fees
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('tax fees '),
              text2: MyServices().capitalizeEachWord('$tax_fees jd'),
              icon_color: color3,
              iconData: Icons.price_change,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // total price for cart .
          TwoTextWithIconTemplate(
              text1: MyServices().capitalizeEachWord('total price'),
              text2: MyServices().capitalizeEachWord('$cart_total_price jd'),
              icon_color: color3,
              iconData: Icons.price_change,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: color1,
                    fontWeight: FontWeight.bold,
                    fontSize: mainh * 0.07 * .25,
                  ),
              height: mainh * 0.07,
              width: mainw * .95),

          // divider .
          Divider(
            color: Colors.black.withOpacity(0.05),
            endIndent: mainw * .95 * 0.05,
            indent: mainw * .95 * 0.05,
            height: mainh * 0.02,
            thickness: 0.5,
          ),

          // space .
          SizedBox(
            width: mainw * .95,
            height: mainh * 0.015,
          )
        ],
      ),
    );
  }
}
