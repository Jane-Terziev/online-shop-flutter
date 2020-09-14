import 'package:flutter/material.dart';
import 'package:online_shop/screens/create_product_screen.dart';
import 'package:online_shop/screens/settings_screen.dart';
import 'package:online_shop/screens/shopping_cart_screen.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'category_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  final Widget child;
  final String title;
  const MainPage ({ Key key, this.child, this.title }): super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  String _title;
  SharedPreferences sharedPreferences;
  Widget _child;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _child = widget.child != null ? widget.child : CategoryScreen();
    _title = widget.title != null ? widget.title : "Categories";
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

  checkout(context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    final response = await http.put(
        BaseApiClient.CHECKOUT_SHOPPING_CART,
        headers: BaseApiClient.getHeaders(token)
    );
    print(response.body);
    if(response.statusCode == 200){
      _showToastSuccess(context);
      setState(() {
        _selectedIndex = 1;
        _child = Center(
          child: Text("Shopping cart is empty.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        );
        _title = 'Shopping Cart';
      });
    }
  }

  void _showToastSuccess(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Checkout successful!', style: TextStyle(color: Colors.white)),
        action: SnackBarAction(
          label: 'Hide', onPressed: _scaffoldKey.currentState.hideCurrentSnackBar, textColor: Colors.white,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text(_title, style: TextStyle(color: Colors.white)),
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              centerTitle: true,
              actions: <Widget>[
                _selectedIndex == 1 ? FlatButton(
                  textColor: Colors.white,
                  onPressed: () {
                    checkout(context);
                  },
                  child: Text("Checkout"),
                  shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                ) : Container()
              ],
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
            ),
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.lightBlue,
              ),
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Image.asset("assets/images/ecorp-lightblue.png"),
                    ),
                    ListTile(
                      title: Center(
                        child: Text('Sell an Item',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => MainPage(
                                  child: CreateProductScreen(),
                                  title: "Add Product",
                                )),
                                (Route<dynamic> route) => false
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }

  void _onItemTapped(int index) {
    switch(index){
      case 0:
        setState(() {
          _selectedIndex = index;
          _child = CategoryScreen();
          _title = 'Categories';
        });
        break;
      case 1:
        setState(() {
          _selectedIndex = index;
          _child = ShoppingCartScreen();
          _title = 'Shopping Cart';
        });
        break;
      case 2:
        setState(() {
          _selectedIndex = index;
          _child = SettingsScreen(sharedPreference: sharedPreferences);
          _title = 'Settings';
        });
        break;
    }
  }
}