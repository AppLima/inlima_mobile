import 'package:flutter/material.dart';

class SosInfo extends StatelessWidget {
  final String imageUrl;
  final String title;

  const SosInfo({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          // Imagen de fondo
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imageUrl), // Cambiado a AssetImage
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenedor para el título centrado
          Positioned.fill(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24, // Título agrandado
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Centrado
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
