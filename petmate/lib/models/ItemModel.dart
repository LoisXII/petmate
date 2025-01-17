class ItemModel {
  String item_id;
  String item_name;
  String item_price;
  String item_image;
  String store_id;

  ItemModel({
    required this.item_image,
    required this.item_name,
    required this.item_price,
    required this.store_id,
    required this.item_id,
  });

  factory ItemModel.FromJson(
      {String? item_id, required Map<String, dynamic> data}) {
    return ItemModel(
        item_image: data['item_image'],
        item_name: data['item_name'],
        item_price: data['item_price'],
        store_id: data['store_id'],
        item_id: item_id ?? (data['item_id'] ?? 'null'));
  }

  Map<String, dynamic> ToJSon() {
    return {
      'item_image': item_image,
      "item_name": item_name,
      "item_price": item_price,
      "store_id": store_id,
      "item_id": item_id,
    };
  }
}
