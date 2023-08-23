import 'package:ParkingApp/GlobalColors.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PopUpPage extends StatelessWidget {
  final String parkingNumber;
  final String email;
  final Stream<QuerySnapshot> stream;
  const PopUpPage(
      {Key? key,
      required this.parkingNumber,
      required this.email,
      required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color3,
        title: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final docs = snapshots.data!.docs;
              final filteredDocs = docs.where((doc) {
                var data = doc.data() as Map<String, dynamic>;
                return data['ParkingOne'].toString() == parkingNumber;
              }).toList();

              if (filteredDocs.isEmpty) {
                return Text('No matching documents found.');
              }

              final document = filteredDocs.first;
              var data = document.data() as Map<String, dynamic>;

              String details = '${data['UnitNum']}\n';

              return GestureDetector(
                onTap: () {
                  // _showDialog(context, details);
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Parking Number: ' +
                                            data['ParkingOne'].toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final docs = snapshots.data!.docs;
            final filteredDocs = docs.where((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return data['ParkingOne'].toString() == parkingNumber;
            }).toList();

            if (filteredDocs.isEmpty) {
              return Text('No matching documents found.');
            }

            final document = filteredDocs.first;
            var data = document.data() as Map<String, dynamic>;

            String details = '${data['UnitNum']}\n';

            return GestureDetector(
              onTap: () {
                // _showDialog(context, details);
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.20,
                            ),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: ''),
                                          WidgetSpan(
                                            child: Image.network(
                                              'https://cdn-icons-png.flaticon.com/128/3005/3005359.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Parking Status: '),
                                    Text(
                                      data['Status'].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Unit Number: ' +
                                          data['UnitNum'].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    int index = filteredDocs.indexOf(document);
                                    String documentId =
                                        filteredDocs[index].reference.id;

                                    if (data['Status'].toString() != 'Booked') {
                                      FirebaseFirestore.instance
                                          .collection('Parking_A')
                                          .doc(documentId)
                                          .update({
                                        'Status': 'Booked',
                                      });
                                      // Add booking information to the "Booking" collection
                                      FirebaseFirestore.instance
                                          .collection('Bookings')
                                          .add({
                                        'ParkingId': documentId,
                                        'BookedParkingNumber':
                                            data['ParkingOne'],
                                        'Date': DateTime.now(),
                                        'UserWhoBooked': email,
                                        'BookedUnit': data['UnitNum']
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 0),
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                              255, 119, 118, 118),
                                          blurRadius: 4,
                                          offset:
                                              Offset(4, 3), // Shadow position
                                        ),
                                      ],
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text("Book"),
                                    ),
                                  ),
                                ),
                              ],
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
        },
      ),
    );
  }
}
