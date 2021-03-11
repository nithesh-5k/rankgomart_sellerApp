import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/Pages/LoginScreen.dart';
import 'package:seller_app/Pages/SideDrawer.dart';
import 'package:seller_app/model/ItemModel.dart';
import 'package:seller_app/provider/SellerDetails.dart';
import 'package:seller_app/request.dart';

class ListProducts extends StatefulWidget {
  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  List<ItemModel> items = [];
  var responseBody;

  Future<void> getItems() async {
    Map<String, String> body = {
      "custom_data": "getsellerbaseditemlist",
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
          getItems();
        });
      } else {
        setState(() {
          items = itemsFromJson(responseBody["itemlist"]);
        });
      }
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        getItems();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (responseBody == null) {
      Future.delayed(Duration(milliseconds: 500), () {
        getItems();
      });
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Products",
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
          : items.length == 0
              ? Center(
                  child: Text("No items available"),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 120,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(child: Image.network(items[index].imageUrl)),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  items[index].itemName,
                                  textAlign: TextAlign.center,
                                ),
                                Text("Rs. ${items[index].itemSalePrice}"),
                                InkWell(
                                  onTap: () {
                                    changeStatus(items[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(7),
                                    color: items[index].itemStockStatus ==
                                            "available"
                                        ? Colors.green
                                        : Colors.red,
                                    child: Text(items[index].itemStockStatus),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: items.length,
                ),
      drawer: SideDrawer(),
    );
  }

  Future<void> changeStatus(ItemModel item) async {
    Map<String, String> body = {
      "custom_data": "changeitemstatus",
      "mainCategoryId": Provider.of<SellerDetails>(context, listen: false)
          .seller
          .mainCategoryId,
      "sellerRefId":
          Provider.of<SellerDetails>(context, listen: false).seller.sellerId,
      "itemId": item.itemId,
      "changeItemStatus":
          item.itemStockStatus == "available" ? "unavailable" : "available"
    };
    print(body);
    responseBody = await postRequest("API/seller_api.php", body);
    if (responseBody['success'] == null ? false : responseBody['success']) {
      if (responseBody['appresponse'] == "failed") {
        Future.delayed(Duration(milliseconds: 500), () {
          changeStatus(item);
        });
      } else {
        getItems();
      }
    }
  }
}
