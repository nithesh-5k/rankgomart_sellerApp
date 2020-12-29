import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/Pages/LoginScreen.dart';
import 'package:seller_app/Pages/SideDrawer.dart';
import 'package:seller_app/const.dart';
import 'package:seller_app/model/order/BakeryOrder.dart';
import 'package:seller_app/model/order/HotelOrder.dart';
import 'package:seller_app/model/order/IOrder.dart';
import 'package:seller_app/model/order/orderItem/OrderIItem.dart';
import 'package:seller_app/provider/SellerDetails.dart';
import 'package:seller_app/request.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var responseBody;
  List<IOrder> everyOrders = [], presentOrders = [];

  Future<void> getOrders() async {
    everyOrders.clear();
    presentOrders.clear();
    Map<String, String> body = {
      "custom_data": "getsellerorderlist",
      "mainCategoryId": Provider.of<SellerDetails>(context, listen: false)
          .seller
          .mainCategoryId,
      "sellerRefId":
          Provider.of<SellerDetails>(context, listen: false).seller.sellerId,
      "orderCurrentStatus": ""
    };
    responseBody = await postRequest("API/seller_api.php", body);
    if (responseBody['success'] == null ? false : responseBody['success']) {
      var temp = responseBody['orderList'];
      if (mounted) {
        setState(() {
          for (int i = 0; i < temp.length; i++) {
            if (temp[i]['mainCategoryId'] == 2) {
              everyOrders.add(HotelOrder.fromJson(temp[i]));
            } else {
              if (temp[i]['mainCategoryId'] == 3) {
                everyOrders.add(BakeryOrder.fromJson(temp[i]));
              }
            }
          }
        });
      }
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        getOrders();
      });
    }
  }

  bool current = true;

  @override
  Widget build(BuildContext context) {
    if (responseBody != null) {
      presentOrders.clear();
      for (int i = 0; i < everyOrders.length; i++) {
        if (everyOrders[i].orderCurrentStatus != "rejected" &&
            everyOrders[i].orderCurrentStatus != "delivered" &&
            everyOrders[i].orderCurrentStatus != "picked") {
          presentOrders.add(everyOrders[i]);
        }
      }
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        getOrders();
      });
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Orders",
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
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              current = true;
                            });
                          },
                          child: Container(
                            color: current ? Colors.grey : Colors.white,
                            child: Center(
                              child: Text(
                                "Current orders",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              current = false;
                            });
                          },
                          child: Container(
                            color: !current ? Colors.grey : Colors.white,
                            child: Center(
                              child: Text(
                                "All orders",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: current && presentOrders.length == 0
                      ? Center(
                          child: Text("Orders are yet to be assigned"),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return orderCard(
                                current
                                    ? presentOrders[index]
                                    : everyOrders[index],
                                context);
                          },
                          itemCount: current
                              ? presentOrders.length
                              : everyOrders.length,
                        ),
                ),
              ],
            ),
      drawer: SideDrawer(),
    );
  }
}

Widget orderCard(IOrder order, BuildContext context) {
  Color buttonColor = Colors.lightBlue;
  String buttonText = "Order placed";
  if (order.orderCurrentStatus == "accepted") {
    buttonText = "Waiting for pickup";
    buttonColor = Colors.amber;
  } else {
    if (order.orderCurrentStatus == "picked") {
      buttonText = "Will be delivered";
      buttonColor = Colors.lightGreen;
    } else {
      if (order.orderCurrentStatus == "delivered") {
        buttonText = "Delivered";
        buttonColor = Colors.green;
      }
    }
  }
  return Container(
    height: 300,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Order ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(order.orderCode)
                ],
              ),
            )
          ],
        ),
        FlatButton(
          color: kGreen,
          child: Center(
            child: Text(
              "ITEMS",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          onPressed: () {
            listItems(order.items, context);
          },
        ),
        Text(
          "Ordered On",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(order.orderCreatedDate),
        Text(
          "Total Amount",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(order.totalOrderAmount),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white),
              ),
              color: buttonColor,
            )
          ],
        )
      ],
    ),
  );
}

Future<dynamic> listItems(List<OrderIItem> items, BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Item Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items[index].name),
                    Row(
                      children: [
                        Text(
                          "Quantity: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(items[index].quantity),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total price:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            " Rs.${(double.parse(items[index].quantity)) * double.parse(items[index].price)}"),
                      ],
                    ),
                    Divider(),
                  ],
                );
              },
              itemCount: items.length,
            ),
          ),
        );
      });
}
