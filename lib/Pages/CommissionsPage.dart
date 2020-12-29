import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/Pages/LoginScreen.dart';
import 'package:seller_app/Pages/SideDrawer.dart';
import 'package:seller_app/const.dart';
import 'package:seller_app/model/commission/BakeryCommission.dart';
import 'package:seller_app/model/commission/Commission.dart';
import 'package:seller_app/model/commission/HotelCommission.dart';
import 'package:seller_app/provider/SellerDetails.dart';
import 'package:seller_app/request.dart';

class CommissionPage extends StatefulWidget {
  @override
  _CommissionState createState() => _CommissionState();
}

class _CommissionState extends State<CommissionPage> {
  var responseBody;
  List<Commission> commissions = [];

  Future<void> getCommissions() async {
    Map<String, String> body = {
      "custom_data": "sellerordercommission",
      "mainCategoryId": Provider.of<SellerDetails>(context, listen: false)
          .seller
          .mainCategoryId,
      "sellerRefId":
          Provider.of<SellerDetails>(context, listen: false).seller.sellerId
    };
    responseBody = await postRequest("API/seller_api.php", body);
    if (responseBody['success'] == null ? false : responseBody['success']) {
      if (responseBody['appresponse'] == "failed") {
        Future.delayed(Duration(milliseconds: 500), () {
          getCommissions();
        });
      } else {
        setState(() {
          if (Provider.of<SellerDetails>(context, listen: false)
                  .seller
                  .mainCategoryId ==
              "2") {
            commissions =
                hotelCommissionFromJson(responseBody["commissionlist"]);
          } else {
            commissions =
                bakeryCommissionFromJson(responseBody["commissionlist"]);
          }
        });
        print(responseBody);
      }
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        getCommissions();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (responseBody == null) {
      Future.delayed(Duration(milliseconds: 500), () {
        getCommissions();
      });
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Commission",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Provider.of<SellerDetails>(context, listen: false).deleteUserId();
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: responseBody == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    color: kGreen,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(child: Center(child: Text("Order Code"))),
                        Expanded(child: Center(child: Text("Commission"))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                              commissions[index].orderCode ??
                                                  ""))),
                                  Expanded(
                                    child: Center(
                                      child: Text(commissions[index]
                                              .totalOrderCommission ??
                                          ""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider()
                          ],
                        );
                      },
                      itemCount: commissions.length,
                    ),
                  ),
                ],
              ),
            ),
      drawer: SideDrawer(),
    );
  }
}
