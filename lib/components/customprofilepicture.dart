import 'dart:io';
import 'package:flutter/material.dart';

class CustomProfilePicture extends StatefulWidget {
  final File? imageFile; // Archivo local de la imagen
  final String? imageUrl; // URL de la imagen
  final VoidCallback onCameraPressed; // Acción para la cámara
  final VoidCallback onGalleryPressed; // Acción para la galería

  const CustomProfilePicture({
    Key? key,
    this.imageFile,
    this.imageUrl,
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
                    width: 150,
                    height: 150,
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
                      child:
                          _buildImage(), // Método para decidir qué imagen mostrar
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
              FloatingActionButton(
                onPressed: widget.onCameraPressed,
                mini: true,
                backgroundColor: Colors.white,
                heroTag: 'cameraButton',
                child: const Icon(Icons.camera_alt, color: Colors.black),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: widget.onGalleryPressed,
                mini: true,
                backgroundColor: Colors.white,
                heroTag: 'galleryButton',
                child: const Icon(Icons.upload, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (widget.imageFile != null) {
      // Mostrar imagen local
      return Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    } else if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      // Mostrar imagen remota
      return Image.network(
        widget.imageUrl!,
        fit: BoxFit.cover,
        width: 150,
        height: 150,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child; // Cuando se carga
          return const Center(
              child: CircularProgressIndicator()); // Mientras carga
        },
        errorBuilder: (context, error, stackTrace) {
          // Fallback a imagen predeterminada en caso de error
          return Image.asset(
            'assets/userDefault.png',
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          );
        },
      );
    } else {
      // Mostrar imagen predeterminada
      return Image.asset(
        'assets/userDefault.png',
        fit: BoxFit.cover,
        width: 150,
        height: 150,
      );
    }
  }
}
