import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import 'DesktopParking-A.dart';

class MobileParkingA extends StatefulWidget {
  final String user_email;
  MobileParkingA(this.user_email);

  @override
  _MobileParkingA createState() => _MobileParkingA();
}

class _MobileParkingA extends State<MobileParkingA> {
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

  Widget _buildParkingAServiceFaceleft(
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
                    ;
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
                      child: Row(
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
          margin: EdgeInsets.all(0.0),
          child: RotatedBox(
            quarterTurns: 3,
            child: Container(
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
                          width: navbarsize / 2,
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
                          width: navbarsize - 10 / 2,
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

                              return Styling2_2(
                                _buildParkingAServiceFaceleft(number),
                              );
                            } else {
                              return Styling2_2(Center(
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
                            top: 30.0 / 2,
                            left: 1392 / 2,
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
                          width: navbarsize / 2,
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
                              width: navbarsize - 7 / 2,
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
                                            color: color1,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Image.network(
                                                        'https://cdn-icons-png.flaticon.com/128/7388/7388979.png'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            width: 50 / 2,
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
                                                fontSize: 15),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Date: $formattedDate',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  width: navbarsize * 2.2 - 16,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      height: 5 / 2,
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
                                          _buildParkingAServiceFaceleft(number),
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
                                      width: 10 / 2,
                                      // color: Colors.yellowAccent,
                                      height: 100 / 2,
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
                                          _buildParkingAServiceFaceleft(number),
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
                                  height: 10 / 2,
                                  // color: Colors.brown,
                                  width: 151 / 2 + 22,
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
                                  height: 45,
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    height: 40,
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/128/9549/9549248.png',
                                    ),
                                  ),
                                  // color: Colors.greenAccent,
                                  width: 100 / 2,
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
                            height: 10 / 2,
                            width: navbarsize * 5 - 140 / 2),
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
                        Container(
                            // color: Colors.indigoAccent,
                            height: 10 / 2,
                            width: 100 / 2),
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
                            height: 10 / 2,
                            width: navbarsize * 4 - 28 / 2),
                        Container(
                            // color: Color.fromARGB(255, 196, 136, 81),
                            height: 10 / 2,
                            width: 488 / 2),
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
                        SizedBox(width: 100 / 2),
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
                        Container(
                          width: navbarsize * 6.6 - 5.2,
                          height: 4,
                          // color: color2,
                        ),
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
                        Container(
                          width: 4.7,
                          height: 4,
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
    ));
  }
}

Container Styling7(value7) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          top: 1.0,
          left: 0,
        ),
        width: 50 / 2,
        height: 70 / 2,
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
          bottom: 14.0 / 2,
          left: 0,
        ),
        width: 50 / 2,
        height: 70 / 2,
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
        width: 50 / 2,
        height: 70 / 2,
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
        width: 50 / 2,
        height: 70 / 2,
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

Container Styling2_2(Value2_2) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          top: 0.0,
          left: 10 / 2,
        ),
        width: 90 / 2,
        height: 50 / 2,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: color3, // Set the bottom border color
            ),
            left: BorderSide(
              color: color3, // Set the bottom border color
            ),
            bottom: BorderSide(
              color: color3, // Set the bottom border color
            ),
          ),
        ),
        child: Value2_2)),
  );
}

Container Styling2(Value2) {
  return Container(
    child: face_up_Containers(Container(
        margin: EdgeInsets.only(
          top: 0.0,
          left: 50 / 2,
        ),
        width: 90 / 2,
        height: 50 / 2,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color3, // Set the bottom border color
            ),
            left: BorderSide(
              color: color3, // Set the bottom border color
            ),
            top: BorderSide(
              color: color3, // Set the bottom border color
            ),
          ),
        ),
        child: Value2)),
  );
}

Container Styling4(BuildContext context, Widget Value4) {
  return Container(
    child: face_up_Containers(Container(
        width: 50 / 2,
        height: 70 / 2,
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
        child: Value4)),
  );
}

Container Styling(BuildContext context, Widget value) {
  return Container(
    child: face_up_Containers(
      Container(
        margin: EdgeInsets.only(
          top: 5.0,
        ),
        width: 50 / 2,
        height: 70 / 2,
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
