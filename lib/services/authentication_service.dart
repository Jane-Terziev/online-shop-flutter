import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop/services/base_api_client.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService extends BaseApiClient {
  static const Duration loginTime = Duration(milliseconds: 2250);

  static Future<String> authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var response = await http.post(BaseApiClient.getBaseURL() + "oauth/token", body: {
        'email': data.name,
        'password': data.password,
        'grant_type': 'password'
      });
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        sharedPreferences.setString("token", jsonResponse["access_token"]);
      } else {
        return "Invalid Credentials";
      }
      return null;
    });
  }

  static Future<String> registerUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      var response = await http.post(BaseApiClient.getBaseURL() + "/users", body: {
        'email': data.name,
        'password': data.password
      });
      if(response.statusCode != 200) {
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