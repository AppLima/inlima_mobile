import 'package:flutter/material.dart';

class SurveyInfo extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;

  const SurveyInfo({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
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
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Contenedor para texto superpuesto
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fecha
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Título del sondeo
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }
}
