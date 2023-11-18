import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/http_result.dart';

class AppProvider {
  static Duration duration = const Duration(seconds: 30);

  Future<HttpResult> _getRequest(String url) async {
    if (kDebugMode) {
      print(url);
    }
    try {
      var response = await http
          .get(
        Uri.parse(url),
        headers: await header(),
      )
          .timeout(duration);
      return _result(response);
    } on TimeoutException {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "Network error",
      );
    } on SocketException {
      return HttpResult(
        isSuccess: false,
        statusCode: -2,
        result: "Network error",
      );
    }
  }

  Future<HttpResult> _postRequest(String url, body) async {
    if (kDebugMode) {
      print(url);
    }
    if (kDebugMode) {
      // print(body);
      print(await header());
    }
    try {
      var response = await http
          .post(
        Uri.parse(url),
        body: body,
        headers: await header(),
      )
          .timeout(duration);
      if (response.statusCode == 201) {}
      return _result(response);
    } on TimeoutException {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "Network error",
      );
    } on SocketException {
      return HttpResult(
        isSuccess: false,
        statusCode: -1,
        result: "Network error",
      );
    }
  }

  header() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    if (token == "") {
      return {
        "Content-Type": "application/json",
      };
    } else {
      return {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
    }
  }

  HttpResult _result(http.Response response) {
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return HttpResult(
        isSuccess: true,
        statusCode: response.statusCode,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    } else {
      return HttpResult(
        isSuccess: false,
        statusCode: response.statusCode,
        result: json.decode(
          utf8.decode(
            response.bodyBytes,
          ),
        ),
      );
    }
  }


  Future<HttpResult> getAnnouncement() async {
    String url = "https://fakestoreapi.com/products";
    return await _getRequest(url);
  }
}
