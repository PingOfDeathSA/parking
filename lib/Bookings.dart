import 'package:ParkingApp/colors.dart';
import 'package:ParkingApp/utils_dropdwon.dart';
import 'package:ParkingApp/utils_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ContainerAdmin extends StatefulWidget {
  final String user_email;
  ContainerAdmin(this.user_email);

  @override
  _ContainerAdminState createState() => _ContainerAdminState();
}

List<int> dropdownValues = HourUtils.hours.toList();
final List<String> items = [
  'Available',
  'Not Available',
];

int _selectedIndex = 0;
String Query = "";
int selectedHour = 1;
int _value = 0;
String enteredText = '';

class _ContainerAdminState extends State<ContainerAdmin> {
  String selectedValue = "none";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCardColor(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Parking_A')
            .where('user_email', isEqualTo: widget.user_email)
            .snapshots(),
        builder: (context, snapshots) {
          return snapshots.connectionState == ConnectionState.waiting
              ? Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: SliderRed,
                      size: 50,
                      secondRingColor: TextColor,
                      thirdRingColor: Colors.purple),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (_selectedIndex == 0) {
                      return Container(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '',
                                style: TextStyle(fontSize: 30),
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 250,
                                width: 400,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: Colors.black,
                                  //     width: 2.0,
                                  //     style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 2,
                                          bottom: 2),
                                      decoration: BoxDecoration(
                                        color: color3,
                                        borderRadius: BorderRadius.circular(10),
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
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Parking Number ",
                                              ),
                                              WidgetSpan(
                                                child: Icon(Icons.car_rental,
                                                    size: 20),
                                              ),
                                              TextSpan(
                                                  text: data['ParkingOne']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: color3)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),

                                    SizedBox(
                                      height: 5,
                                    ),
                                    ToggleSwitch(
                                      minWidth: 100.0,
                                      minHeight: 25,
                                      cornerRadius: 20.0,
                                      activeBgColors: [
                                        [color4!],
                                        [SliderRed!]
                                      ],
                                      activeFgColor: Colors.white,
                                      inactiveBgColor:
                                          Colors.grey.withOpacity(0),
                                      inactiveFgColor: TextColor,
                                      initialLabelIndex:
                                          data['Status'] == 'Available' ? 0 : 1,
                                      totalSwitches: 2,
                                      labels: ['Available', 'Not Available'],
                                      radiusStyle: true,
                                      onToggle: (index) {
                                        if (index == 0) {
                                          selectedValue = "Available";
                                        } else {
                                          selectedValue = "Not Available";
                                        }
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Current Hours "),
                                        Text(
                                            data["AvailabeForTime"].toString()),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Update Hours  "),
                                        DropdownButton<int>(
                                          value: dropdownValues[
                                              index], // Use the selected value for this item
                                          items: HourUtils.hours
                                              .map<DropdownMenuItem<int>>(
                                            (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(
                                                  value.toString(),
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              dropdownValues[index] =
                                                  newValue ?? 1;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: SliderRed,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            if (selectedValue == "none") {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  content: Text(
                                                      'Please Select Status Before Updating.'),
                                                  backgroundColor: SliderRed,
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            } else {
                                              String documentId = snapshots
                                                  .data!.docs[index].id;
                                              try {
                                                await FirebaseFirestore.instance
                                                    .collection('Parking_A')
                                                    .doc(documentId)
                                                    .update({
                                                  'Status': selectedValue,
                                                  'AvailabeForTime':
                                                      dropdownValues[index],
                                                  'DatedUpdated': DateTime.now()
                                                });

                                                setState(() {});

                                                // Show a success Snackbar
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Successfully updated status.'),
                                                    backgroundColor:
                                                        Colors.green,
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ),
                                                );
                                              } catch (error) {
                                                // Handle error if the update fails
                                                print(
                                                    'Error updating status: $error');
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'Update',
                                            style: TextStyle(color: color1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Text(data['user_email'].toString()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (_selectedIndex == 1) {
                      return Container();
                    }

                    return Container();
                  },
                );
        },
      ),
    );
  }
}
