import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraButton extends StatefulWidget {
  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    // Abre la cámara del dispositivo
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _openCamera,
          child: Text('Abrir Cámara'),
        ),
        const SizedBox(height: 20),
        _image == null
            ? Text('No se ha capturado ninguna imagen.')
            : Image.file(
                _image!,
                width: 300,
                height: 300,
              ),
      ],
    );
  }
}
