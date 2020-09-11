import 'package:flutter/material.dart';
import 'package:online_shop/screens/settings_screen.dart';
import 'package:online_shop/screens/shopping_cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'category_screen.dart';
import 'login_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  SharedPreferences sharedPreferences;
  Widget _child = CategoryScreen();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen()),
              (Route<dynamic> route) => false
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ecommerce', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: _child,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shopping Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
    );
  }

  void _onItemTapped(int index) {
    switch(index){
      case 0:
        setState(() {
          _selectedIndex = index;
          _child = CategoryScreen();
        });
        break;
      case 1:
        setState(() {
          _selectedIndex = index;
          _child = ShoppingCartScreen();
        });
        break;
      case 2:
        setState(() {
          _selectedIndex = index;
          _child = SettingsScreen();
        });
        break;
    }
  }
}