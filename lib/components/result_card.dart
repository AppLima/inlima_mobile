import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final int id;
  final String asunto;
  final String descripcion;
  final String fecha;
  final String ubicacion;
  final String estado;
  final List<String> fotos;
  final double latitud; // Nuevo parámetro
  final double longitud; // Nuevo parámetro
  final String distrito; // Nuevo parámetro
  final int usuarioId; // Nuevo parámetro

  const ResultCard({
    Key? key,
    required this.id,
    required this.asunto,
    required this.descripcion,
    required this.fecha,
    required this.ubicacion,
    required this.estado,
    required this.fotos,
    required this.latitud, // Nuevo parámetro requerido
    required this.longitud, // Nuevo parámetro requerido
    required this.distrito, // Nuevo parámetro requerido
    required this.usuarioId, // Nuevo parámetro requerido
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.pushNamed(
          context,
          '/detail',
          arguments: {
            'id': id,
            'asunto': asunto,
            'descripcion': descripcion,
            'fecha': fecha,
            'ubicacion': ubicacion,
            'estado': estado,
            'fotos': fotos,
            'latitud': latitud, // Agregado al mapa de argumentos
            'longitud': longitud, // Agregado al mapa de argumentos
            'distrito': distrito, // Agregado al mapa de argumentos
            'usuarioId': usuarioId, // Agregado al mapa de argumentos
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Queja $id',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Indicador del estado
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: estado == 'Finalizado'
                          ? Colors.green
                          : estado == 'En proceso'
                              ? Colors.yellow
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      estado,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                asunto,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                fecha,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              // Ubicación
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      ubicacion,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
