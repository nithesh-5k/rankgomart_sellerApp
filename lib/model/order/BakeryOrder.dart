import 'package:seller_app/model/order/IOrder.dart';

import 'orderItem/BakeryOrderItem.dart';
import 'orderItem/OrderIItem.dart';

class BakeryOrder implements IOrder {
  @override
  String orderCode;

  @override
  String orderCreatedDate;

  @override
  String orderCurrentStatus;

  @override
  String orderID;

  @override
  List<OrderIItem> items;

  BakeryOrder({
    this.orderCode,
    this.orderCreatedDate,
    this.orderCurrentStatus,
    this.orderID,
    this.items,
    this.mainCategoryId,
    this.totalOrderAmount,
  });

  factory BakeryOrder.fromJson(Map<String, dynamic> json) {
    return BakeryOrder(
      orderCode: json["bakeryOrderCode"],
      orderCreatedDate: json["orderedCreatedDate"],
      orderCurrentStatus: json["orderCurrentStatus"],
      orderID: json["bakeryOrderId"],
      mainCategoryId: json["mainCategoryId"].toString(),
      totalOrderAmount: json["totalOrderAmount"],
      items: bakeryItemsFromJson(json["itemList"]),
    );
  }

  @override
  String mainCategoryId;

  @override
  String totalOrderAmount;
}
