import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ParkingApp/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget parkingAService(String unitNumber) {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('Parking_A')
        // .where('user', isEqualTo: widget.user_email)
        .snapshots(),
    builder: (context, snapshots) {
      if (snapshots.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(
            color: color2,
          ),
        );
      } else {
        final docs = snapshots.data!.docs;
        final filteredDocs = docs.where((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return data['ParkingOne'].toString() == unitNumber;
        }).toList();

        if (filteredDocs.isEmpty) {
          return Text('No matching documents found.');
        }

        final document = filteredDocs.first;
        var data = document.data() as Map<String, dynamic>;

        final currentDate = DateTime.now();
        final formattedDate = DateFormat('dd MMMM yyyy').format(currentDate);

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Text('Date: $formattedDate'),
              Text(data['ParkingOne'].toString()),
              Text(data['Status'].toString()),
              Text(data['UnitNum'].toString()),
              // Add other widgets to display the document data as needed
            ],
          ),
        );
      }
    },
  );
}
