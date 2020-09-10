import 'package:flutter/material.dart';

import 'screens/category_screen.dart';
import 'screens/login_screen.dart';

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
      routes: {
        '/': (context) => LoginScreen(),
        '/categories': (context) => CategoryScreen(),
      },
    );
  }
}
