import 'package:ParkingApp/SignUp.dart';
import 'package:ParkingApp/userlogin.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen11(onClickedSignUp: toggle)
      : SignUpScreen11(onClickedSignUp: toggle);
  void toggle() => setState(() => {isLogin = !isLogin});
}
