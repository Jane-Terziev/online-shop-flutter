import 'package:shared_preferences/shared_preferences.dart';

class BaseApiClient {
  static const String BASE_URL = "https://online-shop-rails-api.herokuapp.com/";
  static const String CLIENT_URL = BASE_URL + "api/v1/client";
  static const String LOGIN_URL = BASE_URL + "/oauth/token";
  static const String REGISTER_URL = CLIENT_URL + "/users";
  static const String CATEGORY_URL = CLIENT_URL + "/categories";

  static String getBaseURL(){
    return BASE_URL;
  }

  static String getProductByCategoryURL(String category_id){
    return CATEGORY_URL + "/" + category_id + "/products";
  }

  static Map<String, String> getHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}