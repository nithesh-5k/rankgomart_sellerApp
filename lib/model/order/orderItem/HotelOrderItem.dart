import 'package:seller_app/model/order/orderItem/OrderIItem.dart';

class HotelOrderItem implements OrderIItem {
  @override
  String name;

  @override
  String price;

  @override
  String quantity;

  HotelOrderItem({this.quantity, this.price, this.name});

  factory HotelOrderItem.fromJson(Map<String, dynamic> json) {
    return HotelOrderItem(
      name: json["itemName"],
      price: json["customerOrderItemSalePrice"],
      quantity: json["customerOrderItemQuantity"],
    );
  }
}

List<HotelOrderItem> hotelItemsFromJson(responseBody) =>
    List<HotelOrderItem>.from(
        responseBody.map((x) => HotelOrderItem.fromJson(x)));
