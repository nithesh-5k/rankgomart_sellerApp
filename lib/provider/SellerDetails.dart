import 'package:flutter/material.dart';
import 'package:seller_app/model/SellerModel.dart';
import 'package:seller_app/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerDetails extends ChangeNotifier {
  SellerModel seller;
  String pass, uname;

  Future<void> storeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uname", uname);
    await prefs.setString("pass", pass);
  }

  Future<void> fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uname = (prefs.getString("uname") ?? null);
    pass = (prefs.getString("pass") ?? null);
  }

  Future<void> deleteUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uname", null);
    await prefs.setString("pass", null);
    uname = null;
    pass = null;
  }

  Future<bool> checkLogin() async {
    await fetchUserId();
    if (pass != null && uname != null) {
      await getUserDetails(uname, pass);
    }
    return pass == null || uname == null;
  }

  var responseBody;

  Future<String> getUserDetails(String uname, String pass) async {
    this.uname = uname;
    this.pass = pass;
    Map<String, String> body = {
      "custom_data": "verifysellerlogin",
      "username": uname,
      "password": pass
    };
    responseBody = await postRequest("API/seller_api.php", body);
    if (responseBody['success'] == null ? false : responseBody['success']) {
      if (responseBody['appresponse'] == "failed") {
        return responseBody['errormessage'];
      } else {
        seller = SellerModel.fromJson(responseBody);
        storeUserId();
        return "Login done!";
      }
    }
  }
}
