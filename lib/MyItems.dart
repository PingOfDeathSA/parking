import 'package:ParkingApp/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

class MyItems extends StatefulWidget {
  final String user_email;
  MyItems(this.user_email);

  @override
  _MyItems createState() => _MyItems();
}

int _selectedIndex = 0;
String Query = "";

class _MyItems extends State<MyItems> {
  String? selectedValue;

  FutureOr<void> deleteItem(String docId) async {
    await FirebaseFirestore.instance
        .collection('MarketListing')
        .doc(docId)
        .delete();
    // You can perform additional tasks after deletion if needed
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: getCardColor(),
      appBar: AppBar(
        title: SelectableText(
          'Market-Place',
          style: TextStyle(color: color3, fontWeight: FontWeight.bold),
        ),
        backgroundColor: getCardColor(),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('MarketListing').snapshots(),
        builder: (context, snapshots) {
          return snapshots.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: snapshots.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (_selectedIndex == 0) {
                      final List<String> images = [
                        data['Image_1_link'],
                        data['Image_2_link'],
                        data['Image_3_link'],
                      ];
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    decoration: BoxDecoration(
                                      color: color2,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      (data['name'].toString().length > 15)
                                          ? data['name']
                                                  .toString()
                                                  .substring(0, 27) +
                                              '...'
                                          : data['name'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: width < 868 ? 100 : 200,
                                viewportFraction: width < 768 ? 0.5 : 0.6,
                                enlargeCenterPage: true,
                              ),
                              items: images
                                  .map((item) => GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 5, right: 5),
                                                  decoration: BoxDecoration(
                                                    color: color2,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    (data['name']
                                                                .toString()
                                                                .length >
                                                            15)
                                                        ? data['name']
                                                                .toString()
                                                                .substring(
                                                                    0, 27) +
                                                            '...'
                                                        : data['name']
                                                            .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                content: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 300,
                                                      width: 300,
                                                      child: CarouselSlider(
                                                        options:
                                                            CarouselOptions(
                                                          viewportFraction:
                                                              width < 768
                                                                  ? 0.7
                                                                  : 0.7,
                                                          enlargeCenterPage:
                                                              true,
                                                        ),
                                                        items: images
                                                            .map(
                                                              (item) =>
                                                                  Container(
                                                                width: double
                                                                    .infinity,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      item,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      CircularProgressIndicator(),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      width: 300,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children:
                                                                List.generate(
                                                                    images
                                                                        .length,
                                                                    (index) {
                                                              return Icon(
                                                                Icons.circle,
                                                                size: 10,
                                                                color: index ==
                                                                        2
                                                                    ? color2
                                                                    : color3,
                                                              );
                                                            }),
                                                          ),
                                                          Text(
                                                            "  " +
                                                                data['Item_Condition']
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: color2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                data['UserContact']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        color3,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            data['Item_Details']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 13),
                                                          ),
                                                          Text(data[
                                                                  'DateUploaded']
                                                              .toString())
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          color: color2),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: item,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(images.length, (index) {
                                return Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: index == 2 ? color2 : color3,
                                );
                              }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('R ' + data['Price'].toString() + ".00"),
                                Text(
                                  "  " + data['UserContact'].toString(),
                                  style: TextStyle(
                                      color: color2,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Image.network(
                                      'https://cdn-icons-png.flaticon.com/128/9790/9790368.png'),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirmation'),
                                          content: Text(
                                              'Are you sure you want to delete this item?'),
                                          actions: [
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Delete'),
                                              onPressed: () {
                                                deleteItem(snapshots
                                                    .data!.docs[index].id);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else if (_selectedIndex == 1) {
                      return Container();
                    } else {
                      return Container(); // Add your desired widget here for other cases
                    }
                  },
                );
        },
      ),
    );
  }
}
