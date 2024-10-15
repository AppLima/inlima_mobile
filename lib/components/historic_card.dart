import 'package:flutter/material.dart';
import '../configs/colors.dart';

class HistoricCard extends StatelessWidget {
  final int id;
  final String asunto;
  final String fecha;
  final String ubicacion;
  final String estado;

  const HistoricCard({
    Key? key,
    required this.id,
    required this.asunto,
    required this.fecha,
    required this.ubicacion,
    required this.estado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundInlima,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con el ID y estado
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
                    color: estado == 'Solucionado'
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
            // Mostrar fecha y asunto en lugar de la descripción
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
    );
  }
}
