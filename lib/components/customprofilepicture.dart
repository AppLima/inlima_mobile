import 'dart:io';

import 'package:flutter/material.dart';

class CustomProfilePicture extends StatefulWidget {
  final File? imageFile;
  final VoidCallback onCameraPressed;
  final VoidCallback onGalleryPressed;

  const CustomProfilePicture({
    Key? key,
    this.imageFile,
    required this.onCameraPressed,
    required this.onGalleryPressed,
  }) : super(key: key);

  @override
  _CustomProfilePictureState createState() => _CustomProfilePictureState();
}

class _CustomProfilePictureState extends State<CustomProfilePicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _animateProfilePicture() {
    _controller.forward().then((value) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _animateProfilePicture,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.blue[100]!, Colors.blue[400]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: widget.imageFile != null
                          ? Image.file(
                              widget.imageFile!,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            )
                          : Image.asset(
                              'assets/userDefault.png', // Imagen por defecto
                              fit: BoxFit.contain,
                              width: 150,
                              height: 150,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón para seleccionar imagen desde la cámara
              FloatingActionButton(
                onPressed: widget.onCameraPressed,
                mini: true,
                backgroundColor: Colors.white,
                heroTag: 'cameraButton', // Asignar un heroTag único
                child: Icon(Icons.camera_alt, color: Colors.black),
              ),
              const SizedBox(width: 20),
              // Botón para seleccionar imagen desde la galería
              FloatingActionButton(
                onPressed: widget.onGalleryPressed,
                mini: true,
                backgroundColor: Colors.white,
                heroTag: 'galleryButton', // Asignar un heroTag único
                child: Icon(Icons.upload, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
