import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/Pages/ListProducts.dart';
import 'package:seller_app/Pages/Orders.dart';
import 'package:seller_app/const.dart';
import 'package:seller_app/provider/SellerDetails.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String uname, pass;
  bool flag = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> checkLogin() async {
    if (await Provider.of<SellerDetails>(context, listen: false).checkLogin()) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          flag = false;
        });
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => OrdersPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<DeliveryBoy>(context, listen: false).deleteUserId();
    if (flag) {
      checkLogin();
    }
    return Scaffold(
      key: _scaffoldKey,
      body: flag
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      color: kGreen, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8),
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            uname = value;
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'User name',
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8),
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            pass = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                            color: Colors.white,
                            onPressed: () async {
                              if (uname == null || pass == null) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text("Every data in every fields"),
                                ));
                              } else {
                                String temp = await Provider.of<SellerDetails>(
                                        context,
                                        listen: false)
                                    .getUserDetails(uname, pass);
                                if (temp == "Login done!") {
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                ListProducts()));
                                  });
                                }
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(temp),
                                ));
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: kGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
