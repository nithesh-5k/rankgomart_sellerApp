import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/Pages/LoginScreen.dart';
import 'package:seller_app/provider/SellerDetails.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SellerDetails(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
