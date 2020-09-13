class BaseApiClient {
  static const String BASE_URL = "https://online-shop-rails-api.herokuapp.com/";
  static const String CLIENT_URL = BASE_URL + "api/v1/client";
  static const String LOGIN_URL = BASE_URL + "/oauth/token";
  static const String REGISTER_URL = CLIENT_URL + "/users";
  static const String CATEGORY_URL = CLIENT_URL + "/categories";
  static const String CREATE_PRODUCT_URL = CLIENT_URL + "/products";
  static const String ADD_TO_CART_URL = CLIENT_URL + "/orders";
  static const String GET_SHOPPING_CART = CLIENT_URL + "/orders";

  static String getBaseURL(){
    return BASE_URL;
  }

  static String getProductByCategoryURL(String category_id){
    return CATEGORY_URL + "/" + category_id + "/products";
  }

  static String getShowProductURL(String category_id){
    return CLIENT_URL + '/product/' + category_id;
  }

  static Map<String, String> getHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}