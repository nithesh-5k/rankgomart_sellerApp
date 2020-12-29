import 'package:seller_app/model/order/orderItem/OrderIItem.dart';

class BakeryOrderItem implements OrderIItem {
  @override
  String name;

  @override
  String price;

  @override
  String quantity;

  BakeryOrderItem({this.quantity, this.price, this.name});

  factory BakeryOrderItem.fromJson(Map<String, dynamic> json) {
    return BakeryOrderItem(
      name: json["itemName"],
      price: json["customerOrderItemSalePrice"],
      quantity: json["customerOrderItemQuantity"],
    );
  }
}

List<BakeryOrderItem> bakeryItemsFromJson(responseBody) =>
    List<BakeryOrderItem>.from(
        responseBody.map((x) => BakeryOrderItem.fromJson(x)));
