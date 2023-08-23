import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'DesktopParking-A.dart';
import 'MobileparkingA.dart';
import 'ScrollVH.dart';


class ParkingsAviews extends StatefulWidget {
  late final String user_email;
  ParkingsAviews(this.user_email);

  @override
  _ParkingsAviews createState() => _ParkingsAviews();
}

class _ParkingsAviews extends State<ParkingsAviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;

          if (width < 600) {
            // Mobile layout
            return MobileParkingA(widget.user_email);
          } else {
            // Desktop layout
            return MyHomePage(widget.user_email);
          }
        },
      ),
    );
  }
}

class TabletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the tablet view layout here
    return Container(
      color: Colors.green,
      child: Center(
        child: Text('Tablet View'),
      ),
    );
  }
}
