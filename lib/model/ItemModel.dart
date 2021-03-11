import 'package:seller_app/const.dart';

class ItemModel {
  String itemId;
  String itemName;
  String imageUrl;
  String itemStockStatus;
  String itemSalePrice;

  ItemModel(
      {this.itemId,
      this.itemName,
      this.imageUrl,
      this.itemStockStatus,
      this.itemSalePrice});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        itemId: json["itemId"],
        itemName: json["itemName"],
        imageUrl: BASE_URL + json["itemImagePath"] + json["itemImage"],
        itemStockStatus: json["itemStockStatus"],
        itemSalePrice: json["itemSalePrice"]);
  }
}

List<ItemModel> itemsFromJson(responseBody) =>
    List<ItemModel>.from(responseBody.map((x) => ItemModel.fromJson(x)));
