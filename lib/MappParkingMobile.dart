import 'package:ParkingApp/colors.dart';
import 'package:ParkingApp/utils_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'dart:async';

import 'Bookings.dart';
import 'CurrentBookedParking.dart';
import 'MyBookedParkings.dart';

class MappedMobileParkings extends StatefulWidget {
  final String user_email;
  MappedMobileParkings(this.user_email);

  @override
  _MappedMobileParkings createState() => _MappedMobileParkings();
}

int _selectedIndex = 0;
String Query = "";
int _value = 0;
double _currentSliderValue = 0;
int selectedOption = 0;
int selectedHours = 0;
String enteredText = '';

class _MappedMobileParkings extends State<MappedMobileParkings> {
  late Timer _timer;
  List<DocumentSnapshot> _parkingData = [];

  @override
  void initState() {
    super.initState();
    _refreshData(); // Initial data fetch
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _refreshData() async {
    QuerySnapshot snapshots = await FirebaseFirestore.instance
        .collection('Parking_A')
        .where('Status', isEqualTo: "Available")
        .get();

    var sortedList = snapshots.docs;
    sortedList.sort((a, b) => (b['DatedUpdated'] as Timestamp)
        .compareTo(a['DatedUpdated'] as Timestamp));

    setState(() {
      _parkingData = sortedList;
    });
  }

  // Define the fading gradient
  final Gradient fadingGradient = LinearGradient(
    colors: [Colors.green, Colors.yellow, Colors.red],
    stops: [0.0, 0.5, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCardColor(),
      appBar: AppBar(
        backgroundColor: getCardColor(),
        elevation: 0,
        title: Center(
          child: Text(
            "Available Parking Slots",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        width: 120,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: getCardColor(), // Use the function to get the color
              ),
              child: Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              title: Text(
                'Update Status',
                style: TextStyle(fontSize: 13),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContainerAdmin(widget.user_email),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'My Bookings',
                style: TextStyle(fontSize: 13),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBookedParkings(
                      widget.user_email,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Booked Parking',
                style: TextStyle(fontSize: 13),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrentBookedParking(
                      widget.user_email,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 330,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Parking_A')
                  .where('Status', isEqualTo: "Available")
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: LoadingAnimationWidget.discreteCircle(
                        color: SliderRed,
                        size: 50,
                        secondRingColor: TextColor,
                        thirdRingColor: Colors.purple),
                  );
                } else if (snapshots.hasData) {
                  var sortedList = snapshots.data!.docs;
                  sortedList.sort((a, b) => (b['DatedUpdated'] as Timestamp)
                      .compareTo(a['DatedUpdated'] as Timestamp));

                  return ListView.builder(
                    itemCount: sortedList.length,
                    itemBuilder: (context, index) {
                      var data =
                          sortedList[index].data() as Map<String, dynamic>;

                      DateTime updatedDateTime =
                          (data['DatedUpdated'] as Timestamp).toDate();
                      double availableForTime = data['AvailabeForTime'];
                      DateTime hittingTime = updatedDateTime
                          .add(Duration(hours: availableForTime.toInt()));

                      DateTime currentTime = DateTime.now();
                      Duration remainingTime =
                          hittingTime.difference(currentTime);
                      int remainingHours = remainingTime.inHours;

                      return Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            padding: EdgeInsets.only(bottom: 10, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "P",
                                          style: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              color: TextColor),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          data['ParkingOne'].toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                        ),
                                        TextButton(
                                          onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              title: Text(
                                                'Parking Available Till ${DateFormat('HH:mm dd-MM-yy ').format(hittingTime)}',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: SingleChildScrollView(
                                                  child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Parking Rate         '),
                                                      Text(
                                                        'R15.00/hour',
                                                        style: TextStyle(
                                                            color: SliderRed),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Parking Number  ",
                                                      ),
                                                      Text(
                                                        data['ParkingOne']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: SliderRed,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Hours left              '),
                                                      Text(
                                                        remainingHours
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: SliderRed,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "Enter Hours          "),
                                                          Container(
                                                            width: 80,
                                                            height: 30,
                                                            child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  gapPadding: 0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              getCardColor(),
                                                                          width:
                                                                              1.0),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              getCardColor(),
                                                                          width:
                                                                              1.0),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                    getCardColor(),
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            0),
                                                                counterText: '',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10), // Set the border radius
                                                                ),
                                                                hintText: '',
                                                                labelText: "",
                                                              ),
                                                              maxLength: 2,
                                                              onChanged:
                                                                  (text) {
                                                                setState(() {
                                                                  enteredText =
                                                                      text;
                                                                });
                                                              },
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9]')), // Allow only numbers
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    int? parsedEnteredText =
                                                        int.tryParse(
                                                            enteredText);

                                                    if (parsedEnteredText ==
                                                            null ||
                                                        parsedEnteredText >
                                                            remainingHours ||
                                                        parsedEnteredText ==
                                                            0) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'Hours not available'),
                                                          backgroundColor:
                                                              SliderRed,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      );

                                                      Navigator.pop(context);
                                                    } else {
                                                      QuerySnapshot snapshot =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Parking_A')
                                                              .where(
                                                                  'ParkingOne',
                                                                  isEqualTo: data[
                                                                          'ParkingOne']
                                                                      .toString())
                                                              .get();

                                                      if (snapshot
                                                          .docs.isNotEmpty) {
                                                        // Assuming there's only one document matching the condition
                                                        DocumentSnapshot
                                                            document =
                                                            snapshot.docs.first;
                                                        String documentId =
                                                            document.id;

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Parking_A')
                                                            .doc(documentId)
                                                            .update({
                                                          'Status': 'Booked',
                                                        });

                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                'Successfully Booked'),
                                                            backgroundColor:
                                                                color4,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        );
                                                        final parkingRate = 15;
                                                        final parkingFine =
                                                            parkingRate *
                                                                parsedEnteredText;
                                                        print(parkingFine);
                                                        Navigator.pop(context);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Bookings')
                                                            .add({
                                                          'ParkingId':
                                                              documentId,
                                                          'BookedParkingNumber':
                                                              data[
                                                                  'ParkingOne'],
                                                          'Date':
                                                              DateTime.now(),
                                                          'UserWhoBooked':
                                                              widget.user_email,
                                                          'BookedUnit':
                                                              data['UnitNum'],
                                                          "TotalHoursBooked":
                                                              parsedEnteredText,
                                                          'Fine': parkingFine,
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          child: Text(
                                            'Book',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: TextColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SfSliderTheme(
                                      data: SfSliderThemeData(
                                        overlayRadius: 10,
                                        overlayColor: getCardColor(),
                                        activeTrackHeight: 5,
                                        activeTrackColor: Slidergreen,
                                        inactiveTrackHeight: 5,
                                        inactiveTrackColor: SliderRed,
                                        thumbRadius: 12,
                                        thumbColor: remainingHours < 5
                                            ? SliderRed
                                            : color4,
                                      ),
                                      child: SfSlider(
                                        min: 0.0,
                                        max: data['AvailabeForTime'],
                                        value: remainingHours.toDouble(),
                                        trackShape: CustomSfTrackShape(),
                                        thumbIcon: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              remainingHours.toString(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  letterSpacing: 1),
                                            ),
                                          ],
                                        ),
                                        onChanged: (dynamic newValue) {
                                          setState(() {
                                            _value = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'until ${DateFormat('HH:mm dd-MM-yy ').format(hittingTime)}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 1,
                                              fontSize: 10),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Text(
                                          'Hours Left $remainingHours',
                                          style: TextStyle(
                                              color: remainingHours < 5
                                                  ? color2
                                                  : Slidergreen,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
