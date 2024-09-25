import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageUploader(),
    );
  }
}

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _image;
  final picker = ImagePicker();

  // URL de la imagen en Firebase Storage
  final String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/inlima-snapcloud.appspot.com/o/quejas%2Ftraka.jpg?alt=media&token=03805517-5ecb-4cdd-b495-9264ba3437bc';

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      try {
        String fileName = _image!.path.split('/').last;
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child('images/$fileName');
        await ref.putFile(_image!);
        print('Image uploaded successfully');
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Mostrar la imagen desde Firebase Storage usando la URL
            Image.network(imageUrl),
            SizedBox(height: 20),
            _image != null
                ? Image.file(_image!)
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
