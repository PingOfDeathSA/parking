import 'dart:io';
import 'package:ParkingApp/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  PickedFile? _pickedFile;

  FutureOr<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _pickedFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              child: imageWidget,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color3,
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Select Image'),
            ),
            SizedBox(
              height: 10,
            ),
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
