import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularButton extends StatelessWidget {
  final String svgPath;
  final String topic;

  const CircularButton({
    Key? key,
    required this.svgPath,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Verifica que la URL está correcta
    print('Cargando imagen desde: $svgPath');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/description',
          arguments: topic, // Pasar el topic como argumento
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 24,
        height: (MediaQuery.of(context).size.width / 2) - 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.network(
            svgPath, // Cargar el SVG desde la red
            fit: BoxFit.contain,
            placeholderBuilder: (BuildContext context) =>
                const CircularProgressIndicator(), // Indicador de carga mientras se descarga
          ),
        ),
      ),
    );
  }
}
