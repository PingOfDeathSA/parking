import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:ParkingApp/colors.dart';
import 'package:flutter/material.dart';

import 'Bookings.dart';
import 'CurrentBookedParking.dart';
import 'MyBookedParkings.dart';

class Taps extends StatefulWidget {
  final String user_email;
  Taps(this.user_email);
  @override
  _TapsState createState() => _TapsState();
}

class _TapsState extends State<Taps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: color3,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.directions_car,
                    ),
                    text: "My Parkings",
                  ),
                  Tab(
                    icon: Icon(Icons.bookmark),
                    text: "My Booked Parking",
                  ),
                  Tab(
                    icon: Icon(Icons.people),
                    text: "Booked Parking in My Spot",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ContainerAdmin(
                      widget.user_email,
                    ),
                    MyBookedParkings(
                      widget.user_email,
                    ),
                    CurrentBookedParking(
                      widget.user_email,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
