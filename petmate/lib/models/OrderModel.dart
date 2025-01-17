import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:petmate/models/ItemModel.dart';

class OrderModel {
  final String user_name;
  final String order_date;
  final String store_id;
  final String user_id;
  final String phone_number;
  final List<ItemModel> items;
  final String order_id;
  final String stauts;
  final double cart_total_price;
  final double delivery_fees;
  final double item_total_price;
  final double tax_fees;

  OrderModel({
    required this.items,
    required this.tax_fees,
    required this.stauts,
    required this.phone_number,
    required this.order_id,
    required this.order_date,
    required this.store_id,
    required this.user_id,
    required this.user_name,
    required this.cart_total_price,
    required this.delivery_fees,
    required this.item_total_price,
  });

  factory OrderModel.FromJson(
      {required String order_id, required Map<String, dynamic> data}) {
    return OrderModel(
      cart_total_price: data['cart_total_price'],
      delivery_fees: data['delivery_fees'],
      item_total_price: data['item_total_price'],
      items: (data['items'] as List<dynamic>)
          .map(
            (e) => ItemModel.FromJson(item_id: e['item_id'], data: e),
          )
          .toList(),
      order_date: DateFormat("yyyy/MM/dd - hh:mm a")
          .format((data['order_date'] as Timestamp).toDate()),
      stauts: data['status'],
      store_id: data['store_id'],
      phone_number: data['phone_number'],
      tax_fees: data['tax_fees'],
      user_id: data['user_id'],
      user_name: data['user_name'],
      order_id: order_id,
    );
  }
}
