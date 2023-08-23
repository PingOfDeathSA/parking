import 'dart:ui';

import 'package:ParkingApp/PopUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors.dart';

class ParkingA extends StatefulWidget {
  final String user_email;
  ParkingA(this.user_email);

  @override
  _ParkingA createState() => _ParkingA();
}

class _ParkingA extends State<ParkingA> {
  Widget _buildParkingAService(
    String serviceNumber,
  ) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Parking_A').snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final docs = snapshots.data!.docs;
          final filteredDocs = docs.where((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return data['ParkingOne'].toString() == serviceNumber;
          }).toList();

          if (filteredDocs.isEmpty) {
            return Text('No matching documents found.');
          }

          final document = filteredDocs.first;
          var data = document.data() as Map<String, dynamic>;

          String details = 'Service Number: ${data['ParkingOne']}\n'
              'Status: ${data['Status']}';

          return GestureDetector(
            onTap: (data['Status'] != 'Not Available' &&
                    data['Status'] != 'Booked')
                ? () {
                    openPopUpPage(
                        context,
                        serviceNumber.toString(),
                        widget.user_email.toString(),
                        FirebaseFirestore.instance
                            .collection('Parking_A')
                            .snapshots());
                  }
                : null,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                // width: 47,
                // color: data['Status'] == 'Not Available'
                //     ? Color.fromARGB(255, 224, 167, 167)
                //     : Color.fromARGB(255, 188, 228, 190),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Text(
                                    data['ParkingOne'].toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Image.network(
                                    data['Status'] == 'Available'
                                        ? 'https://cdn-icons-png.flaticon.com/128/9426/9426997.png'
                                        : (data['Status'] == 'Not Available'
                                            ? 'https://cdn-icons-png.flaticon.com/128/5974/5974771.png'
                                            : 'https://cdn-icons-png.flaticon.com/128/6897/6897039.png'),
                                    width: 14,
                                    height: 14,
                                    color: null, // Remove the color property
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
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd MMMM yyyy').format(currentDate);
// Top Left Raws
    // parking index to insert parking number: max index 11 form index 0
    List<int> TopRaw_leftIndexs = [4, 9, 11];
    // parking numbers to insert
    List<String> TopRaw_leftspecificNumbers = ['111A', '344A', '139B'];

// Top Right Raws
    // parking index to insert parking number: max index 14 form index 0
    List<int> TopRaw_RightIndexs = [0, 9, 7, 14];
    // parking numbers to insert
    List<String> TopRawRightspecificNumbers = ['111A', '139A', '145A', '111A'];

// Face left  Raws
    //    // parking index to insert parking number: max index 1 form index 0s
    List<int> FaceleftIndexs = [
      0,
      1,
    ];
    // parking numbers to insert
    List<String> Face_leftspecificNumbers = [
      '111A',
      '344A',
    ];

// Face up below top left  Raws
    //    // parking index to insert parking number: max index 2 form index 0s
    List<int> Face_Up_Below_to_Left_Indexs = [0, 1, 2];
    // parking numbers to insert
    List<String> Face_Up_Below_to_Left_specificNumbers = [
      '111A',
      '344A',
      '344A',
    ];

    double width = MediaQuery.of(context).size.width;
    double? navbarsize = width < 768 ? 100 : 160;
    // double angle = width < 768 ? 1.566 : 0.0;

    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Container(
            child: Transform.rotate(
              // angle: width < 768 ? 1.570 : 0.0,
              angle: 0,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          // color: Colors.orange,
                          width: navbarsize,
                        ),
                        // Top left Raws
                        Row(
                          children: List.generate(12, (index) {
                            if (TopRaw_leftIndexs.contains(index)) {
                              final specificIndextopleft =
                                  TopRaw_leftIndexs.indexOf(index);
                              final number = TopRaw_leftspecificNumbers[
                                  specificIndextopleft];

                              return Styling(
                                  context, _buildParkingAService(number));
                            } else {
                              return Styling(
                                  context,
                                  Center(
                                    child: Text(
                                      'No Parking Number',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ));
                            }
                          }),
                        ),
                        Container(
                          height: 20,
                          // color: Colors.red,
                          width: navbarsize - 10,
                        ),
                        // Top right Raws
                        Row(
                          children: List.generate(15, (index) {
                            if (TopRaw_RightIndexs.contains(index)) {
                              final specificIndexTopRight =
                                  TopRaw_RightIndexs.indexOf(index);
                              final number = TopRawRightspecificNumbers[
                                  specificIndexTopRight];

                              return Styling(
                                  context, _buildParkingAService(number));
                            } else {
                              return Styling(
                                  context,
                                  Center(
                                    child: Text(
                                      'No Parking Number',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ));
                            }
                          }),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(2, (index) {
                            if (FaceleftIndexs.contains(index)) {
                              final specificIndex_Face_Left =
                                  FaceleftIndexs.indexOf(index);
                              final number = Face_leftspecificNumbers[
                                  specificIndex_Face_Left];

                              return Styling2(
                                _buildParkingAService(number),
                              );
                            } else {
                              return Styling2(Center(
                                child: Text(
                                  'No Parking Number',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ));
                            }
                          }),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 30.0,
                            left: 1356,
                            // left: 1356,
                          ),
                          child: Row(
                            children: List.generate(3, (index) {
                              if (Face_Up_Below_to_Left_Indexs.contains(
                                  index)) {
                                final specificIndex_Face_Up =
                                    Face_Up_Below_to_Left_Indexs.indexOf(index);
                                final number =
                                    Face_Up_Below_to_Left_specificNumbers[
                                        specificIndex_Face_Up];

                                return Styling4(
                                    context, _buildParkingAService(number));
                              } else {
                                return Styling4(
                                    context,
                                    Center(
                                      child: Text(
                                        'No Parking Number',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ));
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          // color: color4,
                          height: 10,
                          width: navbarsize,
                        ),
                        Row(
                          children: [
                            Row(
                                children: List.generate(9, (index) {
                              if (Face_Up_Below_to_Left_Indexs.contains(
                                  index)) {
                                final specificIndex_Face_Up =
                                    Face_Up_Below_to_Left_Indexs.indexOf(index);
                                final number =
                                    Face_Up_Below_to_Left_specificNumbers[
                                        specificIndex_Face_Up];

                                return Styling3(
                                  _buildParkingAService(number),
                                );
                              } else {
                                return Styling3(Center(
                                  child: Text(
                                    'No Parking Number',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ));
                              }
                            })),
                            Container(
                              height: 10,
                              // color: Colors.black,
                              width: navbarsize - 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                            children: List.generate(1, (index) {
                                          if (Face_Up_Below_to_Left_Indexs
                                              .contains(index)) {
                                            final specificIndex_Face_Up =
                                                Face_Up_Below_to_Left_Indexs
                                                    .indexOf(index);
                                            final number =
                                                Face_Up_Below_to_Left_specificNumbers[
                                                    specificIndex_Face_Up];

                                            return Styling3(
                                              _buildParkingAService(number),
                                            );
                                          } else {
                                            return Styling3(Center(
                                              child: Text(
                                                'No Parking Number',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ));
                                          }
                                        })),
                                        RotatedBox(
                                          quarterTurns: 2,
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 46),
                                            // color: Colors.pink,

                                            width: 50,

                                            child: Image.network(
                                              'https://cdn-icons-png.flaticon.com/128/7388/7388979.png',
                                            ),
                                          ),
                                        ),
                                        Row(
                                            children:
                                                List.generate(13, (index) {
                                          if (Face_Up_Below_to_Left_Indexs
                                              .contains(index)) {
                                            final specificIndex_Face_Up =
                                                Face_Up_Below_to_Left_Indexs
                                                    .indexOf(index);
                                            final number =
                                                Face_Up_Below_to_Left_specificNumbers[
                                                    specificIndex_Face_Up];

                                            return Styling3(
                                              _buildParkingAService(number),
                                            );
                                          } else {
                                            return Styling3(Center(
                                              child: Text(
                                                'No Parking Number',
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ));
                                          }
                                        })),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 2,
                                            bottom: 2),
                                        decoration: BoxDecoration(
                                          color: color2,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Parking A',
                                          style: TextStyle(
                                              color: color1,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('Parking_A')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return CircularProgressIndicator();
                                          }

                                          int availableCount =
                                              0; // Variable to count the number of available parkings

                                          // Loop through the documents in the snapshot
                                          snapshot.data!.docs
                                              .forEach((document) {
                                            if (document['Status'] ==
                                                'Available') {
                                              availableCount++; // Increment the count if the status is 'Available'
                                            }
                                          });

                                          // Display the count
                                          return Text(
                                            'Available Parkings: $availableCount',
                                            style: TextStyle(
                                                color: availableCount > 0
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontSize: 20),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Date: $formattedDate',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  width: navbarsize * 3 - 24,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                        children: List.generate(1, (index) {
                                      if (Face_Up_Below_to_Left_Indexs.contains(
                                          index)) {
                                        final specificIndex_Face_Up =
                                            Face_Up_Below_to_Left_Indexs
                                                .indexOf(index);
                                        final number =
                                            Face_Up_Below_to_Left_specificNumbers[
                                                specificIndex_Face_Up];

                                        return Styling2(
                                          _buildParkingAService(number),
                                        );
                                      } else {
                                        return Styling2(Center(
                                          child: Text(
                                            'No Parking Number',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ));
                                      }
                                    })),
                                    Container(
                                      width: 10,
                                      // color: Colors.yellowAccent,
                                      height: 100,
                                    ),
                                    Column(
                                        children: List.generate(2, (index) {
                                      if (Face_Up_Below_to_Left_Indexs.contains(
                                          index)) {
                                        final specificIndex_Face_Up =
                                            Face_Up_Below_to_Left_Indexs
                                                .indexOf(index);
                                        final number =
                                            Face_Up_Below_to_Left_specificNumbers[
                                                specificIndex_Face_Up];

                                        return Styling2(
                                          _buildParkingAService(number),
                                        );
                                      } else {
                                        return Styling2(Center(
                                          child: Text(
                                            'No Parking Number',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ));
                                      }
                                    })),
                                  ],
                                ),
                                Container(
                                  height: 10,
                                  // color: Colors.brown,
                                  width: 151,
                                ),
                                Row(
                                    children: List.generate(1, (index) {
                                  if (Face_Up_Below_to_Left_Indexs.contains(
                                      index)) {
                                    final specificIndex_Face_Up =
                                        Face_Up_Below_to_Left_Indexs.indexOf(
                                            index);
                                    final number =
                                        Face_Up_Below_to_Left_specificNumbers[
                                            specificIndex_Face_Up];

                                    return Styling5(
                                      _buildParkingAService(number),
                                    );
                                  } else {
                                    return Styling5(Center(
                                      child: Text(
                                        'No Parking Number',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ));
                                  }
                                })),
                                Container(
                                  child: RotatedBox(
                                    quarterTurns: 4,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 25),
                                      // color: Colors.pink,

                                      child: Image.network(
                                        'https://cdn-icons-png.flaticon.com/128/9549/9549248.png',
                                      ),
                                    ),
                                  ),
                                  // color: Colors.greenAccent,
                                  width: 100,
                                ),
                                Row(
                                    children: List.generate(12, (index) {
                                  if (Face_Up_Below_to_Left_Indexs.contains(
                                      index)) {
                                    final specificIndex_Face_Up =
                                        Face_Up_Below_to_Left_Indexs.indexOf(
                                            index);
                                    final number =
                                        Face_Up_Below_to_Left_specificNumbers[
                                            specificIndex_Face_Up];

                                    return Styling5(
                                      _buildParkingAService(number),
                                    );
                                  } else {
                                    return Styling5(Center(
                                      child: Text(
                                        'No Parking Number',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ));
                                  }
                                })),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            // color: Color.fromARGB(255, 182, 70, 185),
                            height: 10,
                            width: navbarsize * 5 - 140),
                        Row(
                            children: List.generate(10, (index) {
                          if (Face_Up_Below_to_Left_Indexs.contains(index)) {
                            final specificIndex_Face_Up =
                                Face_Up_Below_to_Left_Indexs.indexOf(index);
                            final number =
                                Face_Up_Below_to_Left_specificNumbers[
                                    specificIndex_Face_Up];

                            return Styling3(
                              _buildParkingAService(number),
                            );
                          } else {
                            return Styling3(Center(
                              child: Text(
                                'No Parking Number',
                                style: TextStyle(fontSize: 10),
                              ),
                            ));
                          }
                        })),
                        Container(height: 10, width: 100),
                        Row(
                            children: List.generate(6, (index) {
                          if (Face_Up_Below_to_Left_Indexs.contains(index)) {
                            final specificIndex_Face_Up =
                                Face_Up_Below_to_Left_Indexs.indexOf(index);
                            final number =
                                Face_Up_Below_to_Left_specificNumbers[
                                    specificIndex_Face_Up];

                            return Styling3(
                              _buildParkingAService(number),
                            );
                          } else {
                            return Styling3(Center(
                              child: Text(
                                'No Parking Number',
                                style: TextStyle(fontSize: 10),
                              ),
                            ));
                          }
                        })),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            // color: Colors.green,
                            height: 10,
                            width: navbarsize * 4 - 28),
                        Container(
                            // color: Color.fromARGB(255, 196, 136, 81),
                            height: 10,
                            width: 448),
                        Row(
                            children: List.generate(2, (index) {
                          if (Face_Up_Below_to_Left_Indexs.contains(index)) {
                            final specificIndex_Face_Up =
                                Face_Up_Below_to_Left_Indexs.indexOf(index);
                            final number =
                                Face_Up_Below_to_Left_specificNumbers[
                                    specificIndex_Face_Up];

                            return Styling6(
                              _buildParkingAService(number),
                            );
                          } else {
                            return Styling6(Center(
                              child: Text(
                                'No Parking Number',
                                style: TextStyle(fontSize: 10),
                              ),
                            ));
                          }
                        })),
                        SizedBox(width: 100),
                        Row(
                            children: List.generate(6, (index) {
                          if (Face_Up_Below_to_Left_Indexs.contains(index)) {
                            final specificIndex_Face_Up =
                                Face_Up_Below_to_Left_Indexs.indexOf(index);
                            final number =
                                Face_Up_Below_to_Left_specificNumbers[
                                    specificIndex_Face_Up];

                            return Styling6(
                              _buildParkingAService(number),
                            );
                          } else {
                            return Styling6(Center(
                              child: Text(
                                'No Parking Number',
                                style: TextStyle(fontSize: 10),
                              ),
                            ));
                          }
                        })),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: navbarsize * 7 - 10),
                        Row(
                            children: List.generate(9, (index) {
                          if (Face_Up_Below_to_Left_Indexs.contains(index)) {
                            final specificIndex_Face_Up =
                                Face_Up_Below_to_Left_Indexs.indexOf(index);
                            final number =
                                Face_Up_Below_to_Left_specificNumbers[
                                    specificIndex_Face_Up];

                            return Styling7(
                              _buildParkingAService(number),
                            );
                          } else {
                            return Styling7(Center(
                              child: Text(
                                'No Parking Number',
                                style: TextStyle(fontSize: 10),
                              ),
                            ));
                          }
                        })),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class ParkingAPage extends StatefulWidget {
  final String serviceNumber;
  final String user_email;

  ParkingAPage({
    required this.serviceNumber,
    required this.user_email,
  });

  @override
  State<ParkingAPage> createState() => _ParkingAPageState();
}

class _ParkingAPageState extends State<ParkingAPage> {
  void _showDialog(BuildContext context, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Booking Confimed"),
          content: Row(
            children: [
              Text('Thank you'),
            ],
          ),
          actions: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(
                top: 10.0,
                left: 0,
              ),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 175, 96, 76),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color3,
        title: Text('Bookings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Parking_A')
            // .where('user', isEqualTo: widget.user_email)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final docs = snapshots.data!.docs;
            final filteredDocs = docs.where((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return data['ParkingOne'].toString() == widget.serviceNumber;
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
                              width: MediaQuery.of(context).size.width * 0.45,
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
                                      'BookedParkingNumber': data['ParkingOne'],
                                      'Date': DateTime.now(),
                                      'UserWhoBooked': widget.user_email,
                                      'BookedUnit': data['UnitNum']
                                    });

                                    Navigator.of(context).pop();
                                    setState(() {});
                                    _showDialog(context, details);
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

Container Styling7(value7) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          top: 1.0,
          left: 0,
        ),
        width: 50,
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color3, // Set the bottom border color
            ),
            left: BorderSide(
              color: color3, // Set the bottom border color
            ),
            right: BorderSide(
              color: color3, // Set the bottom border color
            ),
          ),
        ),
        child: value7)),
  );
}

Container Styling6(value6) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          bottom: 20.0,
          left: 0,
        ),
        width: 50,
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: color3, // Set the bottom border color
            ),
            left: BorderSide(
              color: color3, // Set the bottom border color
            ),
            right: BorderSide(
              color: color3, // Set the bottom border color
            ),
          ),
        ),
        child: value6)),
  );
}

Container Styling5(value5) {
  return Container(
    child: face_up_Containers(Container(
        width: 50,
        height: 106,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: color3, // Set the bottom border color
            ),
            left: BorderSide(
              color: color3, // Set the bottom border color
            ),
            right: BorderSide(
              color: color3, // Set the bottom border color
            ),
          ),
        ),
        child: value5)),
  );
}

Container Styling3(Value3) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          top: 0.0,
          left: 0,
        ),
        width: 50,
        height: 106,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color3, // Set the bottom border color
            ),
            left: BorderSide(
              color: color3, // Set the bottom border color
            ),
            right: BorderSide(
              color: color3, // Set the bottom border color
            ),
          ),
        ),
        child: Value3)),
  );
}

Container Styling2(Value2) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          top: 0.0,
          left: 50,
        ),
        width: 106,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: color3,
            ),
            left: BorderSide(
              color: color3,
            ),
            bottom: BorderSide(
              color: color3,
            ),
          ),
        ),
        child: Value2)),
  );
}

Container Styling4(BuildContext context, Widget Value4) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Container(
    child: face_up_Containers(Container(
        width: 50,
        height: 106,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color3,
            ),
            left: BorderSide(
              color: color3,
            ),
            right: BorderSide(
              color: color3,
            ),
          ),
        ),
        child: Value4)),
  );
}

void openPopUpPage(BuildContext context, String parkingNumber, String email,
    Stream<QuerySnapshot> Stream) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width /
              2, // Set the desired width of the dialog
          height: MediaQuery.of(context).size.height /
              2, // Set the desired height of the dialog
          child: PopUpPage(
              parkingNumber: parkingNumber, email: email, stream: Stream),
        ),
      );
    },
  );
}

Container Styling(BuildContext context, Widget value) {
  return Container(
    child: face_up_Containers(
      Container(
        margin: EdgeInsets.only(
          top: 5.0,
        ),
        width: 50,
        height: 106,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: color3,
            ),
            left: BorderSide(
              color: color3,
            ),
            right: BorderSide(
              color: color3,
            ),
          ),
        ),
        child: value,
      ),
    ),
  );
}

Container face_up_Containers(allContainers) {
  return Container(
    child: Column(
      children: [allContainers],
    ),
  );
}
