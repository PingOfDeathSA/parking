import 'package:ParkingApp/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:banner_listtile/banner_listtile.dart';

class MyBookedParkings extends StatefulWidget {
  final String user_email;
  MyBookedParkings(this.user_email);

  @override
  _MyBookedParkingsState createState() => _MyBookedParkingsState();
}

int _selectedIndex = 0;
String Query = "";

class _MyBookedParkingsState extends State<MyBookedParkings> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 400,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Bookings')
                .where('UserWhoBooked', isEqualTo: widget.user_email)
                .snapshots(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshots.hasData) {
                var sortedList = snapshots.data!.docs;
                sortedList.sort((a, b) =>
                    (b['Date'] as Timestamp).compareTo(a['Date'] as Timestamp));

                return ListView.builder(
                  itemCount: sortedList.length,
                  itemBuilder: (context, index) {
                    var data = sortedList[index].data() as Map<String, dynamic>;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: color2,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                      child: ListTile(
                        leading: Image.network(
                          "https://cdn-icons-png.flaticon.com/128/3477/3477109.png",
                        ),
                        title: Text(
                          data['BookedUnit'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color3,
                          ),
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Parking Number ",
                                style: TextStyle(
                                  color: color3,
                                ),
                              ),
                              WidgetSpan(
                                child: Icon(
                                  Icons.car_rental,
                                  size: 20,
                                  color: color3,
                                ),
                              ),
                              TextSpan(
                                text: data['BookedParkingNumber'].toString(),
                                style: TextStyle(fontSize: 20, color: color3),
                              ),
                            ],
                          ),
                        ),
                        trailing: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: DateFormat('hh:mm a, MMMM dd').format(
                                    (data['Date'] as Timestamp).toDate()),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: color3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("Error loading bookings."),
                );
              }
            },
          ),
        ),
      ],
    ));
  }
}
