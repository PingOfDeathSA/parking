import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'colors.dart';
import 'forgot_password.dart';
import 'utils.error_for_login.dart';

const String email = 'fredrik.eilertsen@gail.com';
final bool isValid = EmailValidator.validate(email);

class LoginScreen11 extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen11({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginScreen11State createState() => _LoginScreen11State();
}

class _LoginScreen11State extends State<LoginScreen11> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();
  bool _obscureText = true;
  bool isLoading = false;
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

    double space;

    if (width < 768) {
      space = 3;
    } else {
      space = 10;
    }

    if (width < 768) {
      text_size = 9;
    } else {
      text_size = 10;
    }
    return Scaffold(
      backgroundColor: color3,
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            height: 500,
            width: 300,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Park",
                      style: TextStyle(
                        color: color1,
                        fontSize: 30,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 1.0,
                            color: color1,
                          ),
                          Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 2.0,
                            color: color1,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Pro",
                      style: TextStyle(
                        color: color2,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(-0.0, -0.0),
                            blurRadius: 1.0,
                            color: color1,
                          ),
                          Shadow(
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 2.0,
                            color: color1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color1,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        margin: new EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 209, 209, 209),
                        ),
                        child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: emailController,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: color3,
                              ),
                              labelText: "Email",
                              border: InputBorder.none,
                              labelStyle:
                                  TextStyle(fontSize: text_size, color: color3),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Please enter a valid email'
                                    : null),
                      ),
                      InkWell(
                        child: Container(
                          margin: new EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 209, 209, 209),
                          ),
                          child: TextFormField(
                            obscureText: _obscureText,
                            controller: passwordController,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: _togglePasswordVisibility,
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: color3,
                                ),
                              ),
                              labelText: "Password",
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  fontSize: text_size,
                                  color: color3,
                                  fontStyle: FontStyle.italic),
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: color2,
                            ),
                            alignment: Alignment.center,
                            height: 30,
                            width: 60,
                            child: isLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(color3),
                                  )
                                : TextButton(
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                        fontSize: text_size * 1.5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: signin,
                                  ),
                          ),
                        ],
                      ),
                      Container(
                        margin: new EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: color2,
                        ),
                        alignment: Alignment.center,
                        height: 30,
                        width: 150,
                        child: TextButton(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: text_size * 1.5,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PasswordReset()));
                          },
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "No Account? ",
                          children: [
                            // WidgetSpan(
                            //   child: Icon(Icons.add, size: 14),
                            // ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: " Sign up",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: text_size * 1.4,
                                color: color2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  FutureOr signin() async {
    try {
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print("errrrrror is " + e.toString());

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print(e.message);
      } else {
        Utils2.showAlertDialog2(context, "Alert", "No user found");
      }
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        print(signin);
      }
    }
  }
}
