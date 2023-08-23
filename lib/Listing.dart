// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'colors.dart';
import 'imageSelectors/imageSelector3.dart';
import 'utils.error_for_login.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ItemListing extends StatefulWidget {
  final String user_email;
  ItemListing(this.user_email);
  @override
  State<ItemListing> createState() => _ItemListingState();
}

class _ItemListingState extends State<ItemListing> {
  final TextEditingController textEditingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final _formKey = GlobalKey<FormBuilderState>();

  void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  CollectionReference users =
      FirebaseFirestore.instance.collection("MarketListing");
  late String itemTitle = 'None';
  late String itemPrice = 'None';
  late String itemCond = 'None';
  late String UserContacts = 'None';
  late String itemCategory = 'None';
  late String imageUrl = 'None';
  late String image1link = 'None';
  late String image2link = 'None';
  late String image3link = 'None';
  late String itemDeails = 'None';

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? selectedValue;

  PickedFile? _pickedFile;

  FutureOr<void> _submitItem() async {
    final collectionRef =
        FirebaseFirestore.instance.collection('MarketListing');

    if (_formKey.currentState!.validate()) {
      Utils2.showAlertDialog2(context, "Alert", "Item Added");
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

      // Save the data to Firestore without the image URL
      await collectionRef.add({
        "name": itemTitle,
        "Price": itemPrice,
        'UserContact': UserContacts,
        "Item_Condition": itemCond,
        "user": widget.user_email,
        "DateUploaded": formattedDate,
        "Item_Category": itemCategory,
        'Image_1_link': image1link,
        'Image_2_link': image2link,
        'Image_3_link': image3link,
        'Item_Details': itemDeails,
      });
    } else {
      Utils2.showAlertDialog2(context, "Alert", "Fill in the Item listing");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double? Padding = width < 1068 ? 0.0 : 400;
    Widget imageWidget;

    if (_pickedFile != null) {
      if (kIsWeb) {
        imageWidget = Image.network(_pickedFile!.path);
      } else {
        imageWidget = Image.file(File(_pickedFile!.path));
      }
    } else {
      imageWidget = Container();
    }

    List<String> categories = [
      "Home & Garden",
      "Electronics",
      "Clothing & Accessories",
      "Baby & Kids",
      "Sports & Outdoors",
      "Furniture",
      "Appliances",
      "Food",
      "Books & Magazines",
      "Toys & Games",
      "Collectibles & Art",
      "Music & Instruments",
    ];

    final Stream<QuerySnapshot> teachersStream =
        FirebaseFirestore.instance.collection('MarketListing').snapshots();
    return Scaffold(
      backgroundColor: getCardColor(),
      body: Container(
        margin: EdgeInsets.only(
          left: Padding,
          right: Padding,
        ),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            skipDisabled: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('Image 1'),
                    SizedBox(height: 5),
                    Container(
                      height: 580,
                      width: 200,
                      child: UploadImagePage(),
                    ),
                  ],
                ),
                // SizedBox(height: 10),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     Text('Image 2'),
                //     SizedBox(height: 5),
                //     Container(
                //       height: 180,
                //       width: 200,
                //       child: ImagePickerPage(),
                //     ),
                //   ],
                // ),

                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Image 1 link',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter image link';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        image1link = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 400,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Image 2 link',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter image link';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        image2link = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 400,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Image 3 link',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter image link';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        image3link = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 400,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Item Name',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Title';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        itemTitle = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 400,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Details',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Details';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        itemDeails = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')) // Only allow digits
                    ],
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.call_rounded,
                          color: color3,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'Contacts',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Contact Details';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        UserContacts = value;
                      });
                    },
                  ),
                ),

                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color3.withOpacity(0.2),
                  ),
                  child: TextFormField(
                    maxLength: 7,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')) // Only allow digits
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: 'R',
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Price';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        itemPrice = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color2.withOpacity(0.2),
                  ),
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: categories
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select Category.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        itemCategory = value.toString();
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color2.withOpacity(0.2),
                  ),
                  child: FormBuilderRadioGroup<String>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Condition',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      labelStyle: TextStyle(fontSize: 20),
                    ),
                    initialValue: null,
                    name: 'Item_Condition',
                    onChanged: (value) {
                      setState(() {
                        itemCond = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please Select Condition';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                    options: [
                      'Brand New',
                      'Like New',
                      'Used',
                    ]
                        .map(
                          (lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text(lang),
                          ),
                        )
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                    activeColor: color3,
                    hoverColor: color2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _submitItem,
                  style: ElevatedButton.styleFrom(
                    primary: color2,
                    // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: const Text(
                    'Add Item',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
