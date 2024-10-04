import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComplaintButtonCard extends StatelessWidget {
  final String svgPath;
  final String topic;

  const ComplaintButtonCard({
    Key? key,
    required this.svgPath,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén el ancho total de la pantalla con padding
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/description',
          arguments: topic, // Pasar el topic como argumento
        );
      },
      child: Container(
        width: screenWidth - 32, // Todo el ancho de la pantalla menos el padding
        margin: const EdgeInsets.symmetric(vertical: 8), // Espacio vertical entre los botones
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(15), // Esquinas redondeadas
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding dentro de la tarjeta
          child: Row(
            children: [
              Expanded(
                child: SvgPicture.network(
                  svgPath, // Cargar el SVG desde la red
                  fit: BoxFit.contain,
                  placeholderBuilder: (BuildContext context) =>
                      const CircularProgressIndicator(),
                ),
              ),
              SizedBox(width: 16), // Espacio entre la imagen y el texto
              Expanded(
                child: Text(
                  topic,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
