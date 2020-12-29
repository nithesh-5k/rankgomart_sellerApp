import 'package:seller_app/model/commission/Commission.dart';

class BakeryCommission extends Commission {
  String orderCode;
  String paidStatus;
  String orderStatus;
  String orderedCreatedDate;
  String totalOrderAmount;
  String totalOrderCommission;

  BakeryCommission(
      {this.orderCode,
      this.paidStatus,
      this.orderStatus,
      this.orderedCreatedDate,
      this.totalOrderAmount,
      this.totalOrderCommission});

  factory BakeryCommission.fromJson(Map<String, dynamic> json) {
    return BakeryCommission(
        orderCode: json["bakeryOrderCode"],
        paidStatus: json["paidStatus"],
        orderStatus: json["orderStatus"],
        orderedCreatedDate: json["orderedCreatedDate"],
        totalOrderAmount: json["totalOrderAmount"],
        totalOrderCommission: json["totalOrderCommission"]);
  }
}

List<BakeryCommission> bakeryCommissionFromJson(responseBody) =>
    List<BakeryCommission>.from(
        responseBody.map((x) => BakeryCommission.fromJson(x)));
