import 'package:seller_app/model/order/orderItem/OrderIItem.dart';

class IOrder {
  String orderID;
  String orderCode;
  String orderCreatedDate;
  String orderCurrentStatus;
  String mainCategoryId;
  String totalOrderAmount;
  List<OrderIItem> items;
}
