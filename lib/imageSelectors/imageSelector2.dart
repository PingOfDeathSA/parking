import 'dart:async';
import 'dart:io';
import 'package:ParkingApp/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage2 extends StatefulWidget {
  @override
  _ImagePickerPage2State createState() => _ImagePickerPage2State();
}

class _ImagePickerPage2State extends State<ImagePickerPage2> {
  PickedFile? _pickedFile2;

  FutureOr<void> _pickImage2(ImageSource source) async {
    final picker2 = ImagePicker();
    final pickedFile2 = await picker2.getImage(source: source);

    setState(() {
      _pickedFile2 = pickedFile2;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget2;

    if (_pickedFile2 != null) {
      if (kIsWeb) {
        imageWidget2 = Image.network(_pickedFile2!.path);
      } else {
        imageWidget2 = Image.file(File(_pickedFile2!.path));
      }
    } else {
      imageWidget2 = Container();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: imageWidget2,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color3,
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () => _pickImage2(ImageSource.gallery),
              child: Text('Select Image'),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     primary: color3,
            //     // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            //   ),
            //   onPressed: () => _pickImage(ImageSource.camera),
            //   child: Text('Take Image from Camera'),
            // ),
          ],
        ),
      ),
    );
  }
}
