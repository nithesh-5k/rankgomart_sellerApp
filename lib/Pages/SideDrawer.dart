import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:seller_app/Pages/CommissionsPage.dart';
import 'package:seller_app/Pages/ListProducts.dart';
import 'package:seller_app/Pages/Orders.dart';
import 'package:seller_app/const.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // DrawerOption(
                //   onTap: () {
                //     Navigator.pop(context);
                //     //TODO
                //   },
                //   icon: Icons.home_rounded,
                //   text: "Home",
                // ),
                // DrawerOption(
                //   onTap: () {
                //     Navigator.pop(context);
                //     //TODO
                //   },
                //   icon: Icons.apps,
                //   text: "All Categories",
                // ),
                // DrawerOption(
                //   onTap: () {
                //     Navigator.pop(context);
                //     //TODO
                //   },
                //   icon: Icons.bolt,
                //   text: "Offer Zone",
                // ),
                DrawerOption(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ListProducts()));
                    //TODO
                  },
                  icon: Icons.menu_book,
                  text: "Products",
                ),
                DrawerOption(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) => OrdersPage()));
                  },
                  icon: Icons.business_center,
                  text: "Orders",
                ),
                DrawerOption(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => CommissionPage()));
                  },
                  icon: Icons.description,
                  text: "Commission",
                ),
                // DrawerOption(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   icon: Icons.shopping_cart,
                //   text: "My Cart",
                // ),
                // DrawerOption(
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                //   icon: Icons.person,
                //   text: "My Account",
                // ),
                // DrawerOption(
                //   onTap: () {
                //     Navigator.pop(context);
                //     //TODO
                //   },
                //   icon: Icons.notifications,
                //   text: "Notifications",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  Function onTap;
  IconData icon;
  String text;

  DrawerOption({this.onTap, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              icon,
              color: kDarkGrey,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
