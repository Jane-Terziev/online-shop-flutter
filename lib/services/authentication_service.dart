import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_shop/models/register_data.dart';

class AuthenticationService {
  static const Duration loginTime = Duration(milliseconds: 2250);
  static const  String BASE_URL = "https://online-shop-rails-api.herokuapp.com/";

  static Future<String> authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var response = await http.post(BASE_URL + "oauth/token", body: {
        'email': data.name,
        'password': data.password,
        'grant_type': 'password'
      });
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        sharedPreferences.setString("token", jsonResponse["token"]);
      } else {
        return "Invalid Credentials";
      }
      return null;
    });
  }

  static Future<String> registerUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      var response = await http.post(BASE_URL + "api/v1/client/users", body: {
        'email': data.name,
        'password': data.password
      });
      if(response.statusCode == 200) {
        print("SUCCESS!");
      }
      else {
        Map jsonResponse = convert.jsonDecode(response.body);
        String message = "";
        Map errors = jsonResponse["message"];
        if(errors.containsKey("email")){
          message = errors["email"][0];
        }
        return message;
      }
      return null;
    });
  }

  static Future<String> recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }
}