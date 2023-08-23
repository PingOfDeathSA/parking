import 'dart:async';

import 'package:ParkingApp/colors.dart';
import 'package:ParkingApp/utils_Faild_PASSWORD.dart';
import 'package:ParkingApp/utils_send_PASSWORD.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  const String email = 'fredrik.eilertsen@gail.com';
  final bool isValid = EmailValidator.validate(email);

  print('Email is valid? ' + (isValid ? 'yes' : 'no'));
}

class PasswordReset extends StatefulWidget {
  // final Function() onClickedSignUp;

  // const PasswordReset({
  //   Key? key,
  //   required this.onClickedSignUp,
  // }) : super(key: key);

  @override
  _PasswordReset createState() => _PasswordReset();
}

class _PasswordReset extends State<PasswordReset> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double text_size;

    if (width < 768) {
      text_size = 9;
    } else {
      text_size = 10;
    }
    return Scaffold(
      backgroundColor: color3,
      body: Center(
        child: Card(
          elevation: 8,
          shadowColor: Colors.grey,
          child: Container(
            height: 150,
            width: 300,
            color: Colors.white,
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Container(
                color: color1,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      margin: new EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 209, 209, 209),
                      ),
                      child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: emailController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            labelText: "Email",
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                              fontSize: text_size,
                              color: Color.fromARGB(255, 117, 117, 117),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Please enter a valid email'
                                  : null),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: resetP,
                          child: Container(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: color2,
                            ),
                            alignment: Alignment.center,
                            height: 40,
                            width: 150,
                            child: Container(
                              child: Text(
                                'Reset Password',
                                style: TextStyle(
                                  fontSize: text_size * 1.5,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 60,
                            child: Container(
                                child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "",
                                  ),
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: text_size * 2,
                                      color: color2,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Back',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: text_size * 1.8,
                                      color: color2,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FutureOr resetP() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print("errrrrror is " + e.toString());

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Utils4.showAlertDialog4(context, "Alert", 'Email send');
      } else {
        Utils3.showAlertDialog3(context, "Alert", "No user Email Found.");
      }
    }
  }
}
