import 'dart:async';
import 'dart:math';
import 'package:ParkingApp/Utils_error.dart';
import 'package:ParkingApp/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

void main() {
  const String email = 'fredrik.eilertsen@gmail.com';
  // final bool isValid = EmailValidator.validate(email);

  final bool isValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  print('Email is valid? ' + (isValid ? 'yes' : 'no'));
}

class SignUpScreen11 extends StatefulWidget {
  final Function() onClickedSignUp;

  const SignUpScreen11({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _SignUpScreen11 createState() => _SignUpScreen11();
}

class _SignUpScreen11 extends State<SignUpScreen11> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool pass_requirement_met = false;
  bool Evetogge = false;
  bool _obscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController_con = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return color2;
      }
      return color2;
    }

    double size = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double text_size;
    double image_size;
    double containerSize;
    double space;
    double topsplitSpace;
    double Box_Btwen_img;
    double Containerr;
    double twohandr;
    double hightt;
    var condition = true;

    if (width < 768) {
      image_size = 30;
    } else {
      image_size = 70;
    }
    if (width < 768) {
      twohandr = 200;
    } else {
      twohandr = 400;
    }

    if (width < 768) {
      Box_Btwen_img = 50;
    } else {
      Box_Btwen_img = 100;
    }

    if (width < 768) {
      space = 3;
    } else {
      space = 10;
    }
    if (width < 768) {
      topsplitSpace = 50;
    } else {
      topsplitSpace = 120;
    }

    if (size < 768) {
      hightt = MediaQuery.of(context).size.height / 1.8;
    } else {
      hightt = MediaQuery.of(context).size.height / 1.2;
    }

    if (size < 968) {
      containerSize = MediaQuery.of(context).size.width;
    } else {
      containerSize = MediaQuery.of(context).size.width / 2;
    }
    if (width < 768) {
      image_size = 30;
    } else {
      image_size = 70;
    }

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
          color: Colors.white,
          shadowColor: Colors.grey,
          child: Container(
            height: 500,
            width: 300,
            child: Form(
              key: _formKey,
              child: Container(
                color: color1,
                child: Column(
                  children: [
                    // TextFormField(
                    //   controller: emailController,
                    //   cursorColor: Colors.white,
                    //   textInputAction: TextInputAction.next,
                    //   decoration: InputDecoration(labelText: "Enter User Name"),
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    // ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0),
                      margin: new EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10),
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
                          validator: (email) => email != null &&
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(email)
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
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Password",
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontSize: text_size,
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontStyle: FontStyle.italic),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
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
                          controller: passwordController_con,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: _togglePasswordVisibility,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            labelText: "Confirm Passord",
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontSize: text_size,
                                color: Color.fromARGB(255, 117, 117, 117),
                                fontStyle: FontStyle.italic),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color2,
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      width: 70,
                      child: TextButton(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: text_size * 1.5,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          onPressed: signUp),
                    ),

                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 170,
                      child: Row(
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                text: "Have an Account? ",
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "",
                              children: [
                                // WidgetSpan(
                                //   child: Icon(Icons.add, size: 14),
                                // ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: " Log in",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: text_size * 1.8,
                                    color: color2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        right: 10,
                      ),
                      child: FlutterPwValidator(
                          controller: passwordController,
                          minLength: 6,
                          uppercaseCharCount: 2,
                          numericCharCount: 3,
                          specialCharCount: 1,
                          width: 400,
                          height: 150,
                          onSuccess: () {},
                          onFail: () {}),
                    ),
                    InkWell(
                      child: Container(
                        margin: new EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 5),
                        alignment: Alignment.center,
                        height: 60,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            )),
                            Text.rich(TextSpan(
                                text: 'By continuing, you agree to our ',
                                style: TextStyle(
                                    fontSize: text_size, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Terms of Service',
                                      style: TextStyle(
                                        fontSize: text_size,
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // code to open / launch terms of service link here
                                        }),
                                  TextSpan(
                                      text: ' and ',
                                      style: TextStyle(
                                          fontSize: text_size,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                                fontSize: text_size,
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // code to open / launch privacy policy link here
                                              }),
                                      ]),
                                ])),
                          ],
                        ),
                      ),
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

  _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //this functions checks if you have confirmed your password
  bool checkConfirmedPassword() {
    if (passwordController.text.trim() == passwordController_con.text.trim()) {
      return true;
    } else {
      Utils.showAlertDialog(context, "Alert", "your passwords do not match");
      return false;
    }
  }

  //this function checks if your password meets the minimum password requirements
  checkPasswordRequirements() {
    if (checkConfirmedPassword()) {
      if (checkSixCharacter(passwordController.text.trim()) &&
          checkUpperCase(passwordController.text.trim()) &&
          checkNumber(passwordController.text.trim()) &&
          checkSpecialCharacter(passwordController.text.trim())) {
        return true;
      } else {
        return false;
      }
    }
  }

  checkSixCharacter(text) {
    if (text.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  checkUpperCase(text) {
    var characters = "ABCDEFGHIGKLMNOPQRSTUVWXYZ";
    var count = 0;
    for (var i = 0; i < text.length; i++) {
      if (characters.contains(text[i])) {
        count = count + 1;
      }
    }
    if (count >= 2) {
      return true;
    } else {
      return false;
    }
  }

  checkNumber(text) {
    var characters = "0123456789";
    var count = 0;
    for (var i = 0; i < text.length; i++) {
      if (characters.contains(text[i])) {
        count = count + 1;
      }
    }
    if (count >= 3) {
      return true;
    } else {
      return false;
    }
  }

  checkSpecialCharacter(text) {
    var characters = "!~@#%^&*()_+{}:?><|/.,';][\\=-`" + '\$"';
    var count = 0;
    for (var i = 0; i < text.length; i++) {
      if (characters.contains(text[i])) {
        count = count + 1;
      }
    }
    if (count >= 1) {
      return true;
    } else {
      return false;
    }
  }

  FutureOr signUp() async {
    if (checkPasswordRequirements() && isChecked == true) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        print(e);
        // print("errrrrror is " + e.toString());
      }
    }
    if (checkPasswordRequirements() && isChecked == false) {
      Utils.showAlertDialog(context, "Alert", "please accespt T&Cs");
    } else {
      if (checkSixCharacter(passwordController.text.trim()) == false) {
        Utils.showAlertDialog(
            context, "Alert", "please have at least 6 characters");
      } else if (checkUpperCase(passwordController.text.trim()) == false) {
        Utils.showAlertDialog(
            context, "Alert", "please have at least 2 Upper case");
      } else if (checkNumber(passwordController.text.trim()) == false) {
        Utils.showAlertDialog(
            context, "Alert", "please have at least 3 Numbers");
      } else if (checkSpecialCharacter(passwordController.text.trim()) ==
          false) {
        Utils.showAlertDialog(
            context, "Alert", "please have at least 1 Special Character");
      }
    }

    // if (
    //   // passwordController.text.trim() == passwordController_con.text.trim()
    //     // &&
    //     //     isChecked == true &&

    //     ) {

    // }
  }
}

//  if (e.code == 'user-not-found') {
//           print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//           print('Wrong password provided for that user.');
//         }

//  if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//           print(e.message);
//         } else {
//           Utils.showAlertDialog(
//               context, "Alert", "Check your Email or Password");
//         }

// else {
//       Utils.showAlertDialog(context, "Alert", "Incorrect Password ");
//     }

//  if (isChecked == false) {
//       Utils.showAlertDialog(context, "Alert", "Please Accept T&Cs");
//     }
