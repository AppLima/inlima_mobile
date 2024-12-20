import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detail_controller.dart';
import '../../components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';
import '../../models/queja.dart';

class DetailPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Recibe todos los datos como argumentos
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};

    final DetailController control = Get.put(DetailController());
    // Asigna la queja desde los argumentos directamente al controlador
    control.updateComplaint(
      Queja(
        id: arguments['id'],
        asunto: arguments['asunto'],
        descripcion: arguments['descripcion'],
        ubicacion: arguments['ubicacion'],
        latitud: arguments['latitud'],
        longitud: arguments['longitud'],
        distrito: arguments['distrito'],
        fecha: arguments['fecha'],
        estado: arguments['estado'],
        usuarioId: arguments['usuarioId'],
        fotos: List<String>.from(arguments['fotos']),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: InLimaAppBar(
        isInPerfil: false,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: LateralBar(),
      body: _buildBody(context, control),
    );
  }

  Widget _buildBody(BuildContext context, DetailController control) {
    return SafeArea(
      child: Obx(() {
        final queja = control.complaint.value;

        if (queja == null) {
          return const Center(child: Text('No se encontró la queja.'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Queja ${queja.id}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      queja.asunto,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                queja.descripcion,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.grey),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      queja.ubicacion,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Muestra "..." si el texto es muy largo
                      maxLines: 2, // Limita el texto a 2 líneas
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              SizedBox(
                height: 300, // Altura del mapa
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(queja.latitud, queja.latitud),
                    zoom: 14.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('complaint_location'),
                      position: LatLng(queja.latitud, queja.latitud),
                      infoWindow: InfoWindow(
                        title: 'Ubicación',
                        snippet: queja.ubicacion,
                      ),
                    ),
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Fecha: ${queja.fecha}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              // Muestra las fotos de la queja
              _buildPhotosCarousel(context, queja.fotos),
              const SizedBox(height: 16),
              const Text(
                'Cambiar estado:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildStateSelector(control),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPhotosCarousel(BuildContext context, List<String> fotos) {
    if (fotos.isEmpty) {
      return const Center(child: Text('No hay fotos disponibles.'));
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: fotos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showImageDialog(context, fotos[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.network(fotos[index], fit: BoxFit.cover, width: 200),
            ),
          );
        },
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStateSelector(DetailController control) {
    final estados = ['En proceso', 'Archivado', 'Finalizado'];
    final colores = {
      'En proceso': Colors.yellow,
      'Archivado': Colors.grey,
      'Finalizado': Colors.green,
    };

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: estados.map((estado) {
            return GestureDetector(
              onTap: () {
                control.updateState(estado); // Actualiza el estado seleccionado
              },
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colores[estado],
                      borderRadius: BorderRadius.circular(8),
                      border: estado == control.complaint.value?.estado
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(estado),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Obx(() {
          // Verifica si el estado actual ha cambiado
          if (control.hasStateChanged()) {
            return ElevatedButton(
              onPressed: () {
                print("Actualizando");
                control.updateComplaintStatus();
              },
              child: const Text('Actualizar estado'),
            );
          }
          return const SizedBox(); // No muestra el botón si no hay cambios
        }),
      ],
    );
  }
}
