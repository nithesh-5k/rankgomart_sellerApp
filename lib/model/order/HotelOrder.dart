import 'package:seller_app/model/order/IOrder.dart';
import 'package:seller_app/model/order/orderItem/HotelOrderItem.dart';
import 'package:seller_app/model/order/orderItem/OrderIItem.dart';

class HotelOrder implements IOrder {
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

  HotelOrder({
    this.orderCode,
    this.orderCreatedDate,
    this.orderCurrentStatus,
    this.orderID,
    this.items,
    this.mainCategoryId,
    this.totalOrderAmount,
  });

  factory HotelOrder.fromJson(Map<String, dynamic> json) {
    return HotelOrder(
      orderCode: json["hotelOrderCode"],
      orderCreatedDate: json["orderedCreatedDate"],
      orderCurrentStatus: json["orderCurrentStatus"],
      orderID: json["hotelOrderId"],
      mainCategoryId: json["mainCategoryId"].toString(),
      totalOrderAmount: json["totalOrderAmount"] ?? "",
      items: hotelItemsFromJson(json["itemList"]),
    );
  }

  @override
  String mainCategoryId;

  @override
  String totalOrderAmount;
}

// "hotelOrderId": "1",
// "hotelOrderCode": "HO0001",
// "totalCartAmount": "810.00",
// "orderDeliveryCharge": "0.00",
// "totalOrderAmount": "810.00",
// "paymentMode": "cod",
// "paidStatus": "unpaid",
// "orderCameFrom": "fromsite",
// "orderDeliveryBoyStatus": "allocated",
// "orderCurrentStatus": "rejected",
// "orderedCreatedDate": "2020-11-05 18:58:49",
// "customerName": "test",
// "customerMobileNumber": "9658743455",
// "customerAddress": "ydtct",
// "customerCityName": "Sivaganga",
// "customerStateName": "Tamil Nadu",
// "customerCountryName": "India",
// "chCreatedDate": null,
// "mainCategoryId": 2,
