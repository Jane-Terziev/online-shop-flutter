import 'package:flutter/material.dart';
import 'package:online_shop/screens/login_screen.dart';
import 'package:online_shop/screens/settings_screen.dart';
import 'package:online_shop/screens/shopping_cart_screen.dart';
import 'screens/category_screen.dart';
import 'screens/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textTheme: TextTheme(
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      home: MainPage(),
      routes: {
        '/categories': (context) => CategoryScreen(),
        '/login': (context) => LoginScreen(),
        '/shopping-cart': (context) => ShoppingCartScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
