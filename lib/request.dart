import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seller_app/const.dart';

Future<Map<String, dynamic>> postRequest(url, body) async {
  print(BASE_URL + url);
  print(body);
  final http.Response response =
      await http.post(BASE_URL + url, body: json.encode(body)).timeout(
          Duration(
            seconds: 10,
          ), onTimeout: () {
    return Future.value(http.Response(json.encode(timeoutResponse()), 400));
  }).catchError((error) {
    return Future.value(http.Response(json.encode(errorResponse()), 400));
  });
  Map<String, dynamic> responseBody = json.decode(response.body);
  if (response.statusCode < 300 && response.statusCode >= 200) {
    responseBody.putIfAbsent("success", () => true);
  }
  print(responseBody);
  return responseBody;
}

Future postRequestForList(url, body) async {
  print(BASE_URL + url);
  print(body);
  final http.Response response =
      await http.post(BASE_URL + url, body: json.encode(body)).timeout(
          Duration(
            seconds: 10,
          ), onTimeout: () {
    return Future.value(http.Response(json.encode(timeoutResponse()), 400));
  }).catchError((error) {
    return Future.value(http.Response(json.encode(errorResponse()), 400));
  });

  dynamic items = json.decode(response.body);

  Map<String, dynamic> responseBody = {"items": items};

  if (response.statusCode < 300 && response.statusCode >= 200) {
    responseBody.putIfAbsent("success", () => true);
  }
  print(responseBody);
  return responseBody;
}

Map<String, dynamic> timeoutResponse() {
  return {
    "success": false,
    "message": "Please check your network connection and try again."
  };
}

Map<String, dynamic> errorResponse() {
  return {
    "success": false,
    "message": "Something went wrong, please try again."
  };
}
