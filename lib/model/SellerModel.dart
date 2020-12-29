class SellerModel {
  SellerModel({
    this.sellerId,
    this.mainCategoryId,
    this.hotelName,
    this.status,
  });

  String sellerId;
  String mainCategoryId;
  String hotelName;
  String status;

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
        sellerId: json["sellerDetails"]["sellerId"],
        mainCategoryId: json["mainCategoryId"],
        hotelName: json["sellerDetails"]["sellerHotelName"],
        status: json["sellerDetails"]["sellerStatus"]);
  }
}
