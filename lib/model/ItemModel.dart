import 'package:seller_app/const.dart';

class ItemModel {
  String itemId;
  String itemName;
  String imageUrl;
  String itemStockStatus;

  ItemModel({this.itemId, this.itemName, this.imageUrl, this.itemStockStatus});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        itemId: json["itemId"],
        itemName: json["itemName"],
        imageUrl: BASE_URL + json["itemImagePath"] + json["itemImage"],
        itemStockStatus: json["itemStockStatus"]);
  }
}

List<ItemModel> itemsFromJson(responseBody) =>
    List<ItemModel>.from(responseBody.map((x) => ItemModel.fromJson(x)));
