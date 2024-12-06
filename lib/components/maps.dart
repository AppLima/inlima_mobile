import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MapsApp());

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;

  // Coordenadas iniciales del mapa
  final LatLng _initialPosition = const LatLng(-23.555555, -46.62932);

  // Lista de marcadores
  final Set<Marker> _markers = {};

  // Método llamado al crear el mapa
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Agregar marcador inicial
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('initial'),
          position: _initialPosition,
          infoWindow: const InfoWindow(
            title: 'Ubicación inicial',
            snippet: 'Latitud: -23.555555, Longitud: -46.62932',
          ),
        ),
      );
    });
  }

  // Método para mover el mapa a una nueva ubicación
  void _moveToPosition(LatLng position) {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(position, 14.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12.0,
        ),
        markers: _markers,
        onTap: (LatLng position) {
          // Agregar marcador en la posición seleccionada
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId(position.toString()),
                position: position,
                infoWindow: InfoWindow(
                  title: 'Marcador',
                  snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
                ),
              ),
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ejemplo de mover el mapa a una nueva posición
          const LatLng newPosition = LatLng(-23.55052, -46.633308);
          _moveToPosition(newPosition);
        },
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
