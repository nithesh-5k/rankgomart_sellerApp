import 'package:seller_app/model/commission/Commission.dart';

class HotelCommission extends Commission {
  String orderCode;
  String paidStatus;
  String orderStatus;
  String orderedCreatedDate;
  String totalOrderAmount;
  String totalOrderCommission;

  HotelCommission(
      {this.orderCode,
      this.paidStatus,
      this.orderStatus,
      this.orderedCreatedDate,
      this.totalOrderAmount,
      this.totalOrderCommission});

  factory HotelCommission.fromJson(Map<String, dynamic> json) {
    return HotelCommission(
        orderCode: json["hotelOrderCode"],
        paidStatus: json["paidStatus"],
        orderStatus: json["orderStatus"],
        orderedCreatedDate: json["orderedCreatedDate"],
        totalOrderAmount: json["totalOrderAmount"],
        totalOrderCommission: json["totalOrderCommission"]);
  }
}

List<HotelCommission> hotelCommissionFromJson(responseBody) =>
    List<HotelCommission>.from(
        responseBody.map((x) => HotelCommission.fromJson(x)));
