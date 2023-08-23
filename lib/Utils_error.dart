
import 'package:flutter/material.dart';

import 'colors.dart';

class Utils {
  static showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double size = MediaQuery.of(context).size.width;

        double width = MediaQuery.of(context).size.width;
        double text_size;
     



        if (width < 768) {
          text_size = 9;
        } else {
          text_size = 10;
        }
        return AlertDialog(
          title: Card(
            elevation: 8,
            child: Container(
              alignment: Alignment.center,
              width: 20,
              height: 40,
              color: color2,
              child: Text(
                title,
                style: TextStyle(fontSize: text_size * 2, color: color1),
              ),
            ),
          ),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text(
                "OK",
                style: TextStyle(fontSize: text_size * 2, color: color2),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
