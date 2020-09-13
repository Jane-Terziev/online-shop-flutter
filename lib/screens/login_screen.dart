import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:online_shop/screens/category_screen.dart';
import 'package:online_shop/services/authentication_service.dart';

import 'main_page.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Commerce',
      logo: 'assets/images/ecorp-lightblue.png',
      onLogin: AuthenticationService.authUser,
      onSignup: AuthenticationService.registerUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainPage(),
        ));
      },
      onRecoverPassword: AuthenticationService.recoverPassword,
    );
  }
}