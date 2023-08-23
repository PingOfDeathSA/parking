import 'package:ParkingApp/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CurrentBookedParking extends StatefulWidget {
  final String user_email;
  CurrentBookedParking(this.user_email);

  @override
  _CurrentBookedParkingState createState() => _CurrentBookedParkingState();
}

int _selectedIndex = 0;
String Query = "";

class _CurrentBookedParkingState extends State<CurrentBookedParking> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Parking_A')
            .where('user_email', isEqualTo: widget.user_email)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
            return Container(); // No data available
          }

          var firstDocument = snapshots.data!.docs.first;
          var unitNum = firstDocument['UnitNum'].toString();

          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 400,
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Bookings')
                            .where('BookedUnit', isEqualTo: unitNum)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Container(); // No data available
                          }

                          var sortedList = snapshot.data!.docs;
                          sortedList.sort((a, b) => (b['Date'] as Timestamp)
                              .compareTo(a['Date'] as Timestamp));

                          // Get the last two documents
                          var lastTwoDocs = sortedList.sublist(
                              0, sortedList.length > 2 ? 2 : sortedList.length);

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: lastTwoDocs.length,
                            itemBuilder: (context, index) {
                              var document = lastTwoDocs[index];

                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: 5, left: 5, right: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: color3,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "User Email",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: document['UserWhoBooked'],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ],
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
                                          text: document['BookedParkingNumber']
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 20, color: color3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: DateFormat('hh:mm a, MMMM dd')
                                              .format((document['Date']
                                                      as Timestamp)
                                                  .toDate()),
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
                        },
                      ),
                      // Add more widgets here for the first document
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
