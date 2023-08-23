import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';

class UploadImagePage extends StatefulWidget {
  @override
  _UploadImagePageState createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  PlatformFile? pickedFile;
  String? downloadUrl;
  bool isLoading = false;
  String? errorMessage;

  Future<void> _selectImage() async {
    final pickedImage = await FilePicker.platform.pickFiles();

    if (pickedImage == null) return;
    setState(() {
      pickedFile = pickedImage.files.first;
      downloadUrl = null;
      errorMessage = null;
    });
  }

  Future<void> _uploadImage() async {
    if (pickedFile == null) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;

      final firebase_storage.Reference ref =
          storage.ref().child(pickedFile!.name!);

      final firebase_storage.UploadTask uploadTask =
          ref.putData(pickedFile!.bytes!);

      final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      final url = await taskSnapshot.ref.getDownloadURL();

      print('Temporary URL: $url');

      setState(() {
        downloadUrl = url;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to upload image';
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickedFile != null)
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Center(
                        child: Image.memory(
                          pickedFile!.bytes!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Failed to load image');
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: SelectableText(pickedFile!.name),
                      ),
                    ),
                  ],
                ),
              ),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            SizedBox(height: 16),
            downloadUrl != null
                ? Image.network(
                    downloadUrl!,
                    errorBuilder: (context, error, stackTrace) {
                      print('Image loading error: $error');
                      print(stackTrace);
                      return SelectableText('Failed to load image');
                    },
                  )
                : Container(
                    height: 20,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : (errorMessage != null ? Text(errorMessage!) : null),
                  ),
          ],
        ),
      ),
    );
  }
}
