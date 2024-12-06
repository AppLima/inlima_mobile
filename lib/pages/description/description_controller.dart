import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart'; // Importa geolocator
import '../../components/advise_card.dart';
import '../../apis/complaint_api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DescriptionController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  String subject = '';
  final complaintApi = ComplaintApi();

  //final locationController = TextEditingController();
  //RxString locationError = ''.obs;


  RxList<File> selectedImages = <File>[].obs;
  Rx<String?> descriptionError = Rx<String?>(null);
  Rx<String?> locationError = Rx<String?>(null);
  Rx<String?> districtError = Rx<String?>(null);
  Rx<String?> adviseContent = Rx<String?>(null);
  RxBool isLoading = false.obs; // Indicador de carga

  bool validateFields() {
    final description = descriptionController.text.trim();
    final location = locationController.text.trim();
    final district = districtController.text.trim();

    descriptionError.value = description.isEmpty ? 'Por favor ingrese una descripción.' : null;
    locationError.value = location.isEmpty ? 'Por favor ingrese una ubicación.' : null;
    districtError.value = district.isEmpty ? 'Por favor ingrese el distrito.' : null;

    return descriptionError.value == null &&
        locationError.value == null &&
        districtError.value == null;
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'El servicio de ubicación está desactivado.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'El permiso de ubicación fue denegado.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'El permiso de ubicación está permanentemente denegado.';
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Actualiza el controlador con la ubicación actual
      locationController.text = '${position.latitude}, ${position.longitude}';
    } catch (e) {
      locationError.value = 'Error al obtener la ubicación: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> enviar(BuildContext context) async {
    if (validateFields()) {
      isLoading.value = true; // Inicia la carga
      List<String> downloadUrls = [];

      if (selectedImages.isNotEmpty) {
        downloadUrls = await uploadImages(selectedImages);
      }

      final description = descriptionController.text.trim();
      final location = locationController.text.trim();
      final district = districtController.text.trim();

      final data = {
        "description": description,
        "location_description": location,
        "latitude": -12.04318,
        "longitude": -77.02824,
        "district": 1,
        "subject": 1,
        "photos": downloadUrls
      };

      try {
        final response = await complaintApi.addComplaint(data);
        print("Holaaaaa");
        print(response);
      } catch (e) {
        print("Error: $e");
      }

      printDetails(description, location, district, downloadUrls);

      adviseContent.value = "Queja enviada con éxito";

      // Mostrar el pop-up de aviso
      Advise(
        content: 'Queja enviada',
        route: '/home',
      ).show(context);

      resetData();
      isLoading.value = false; // Finaliza la carga
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> downloadUrls = [];
    for (File image in images) {
      String? downloadUrl = await uploadImage(image);
      if (downloadUrl != null) {
        downloadUrls.add(downloadUrl);
      }
    }
    return downloadUrls;
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final String fileName = imageFile.path.split("/").last;
      Reference ref = _storage.ref().child('quejas/$fileName');

      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );

      UploadTask uploadTask = ref.putFile(imageFile, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error al subir imagen: $e");
      return null;
    }
  }

  Future<void> getCurrentLocationAndAddress() async {
    try {
      // Verifica permisos y servicios de ubicación
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'El servicio de ubicación está desactivado.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'El permiso de ubicación fue denegado.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'El permiso de ubicación está permanentemente denegado.';
      }

      // Obtén la posición actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Obtén la dirección desde las coordenadas
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;

        // Combina la información de dirección
        String address = '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        locationController.text = address;
      } else {
        locationError.value = 'No se pudo obtener la dirección.';
      }
    } catch (e) {
      locationError.value = 'Error al obtener la ubicación: $e';
    }
  }

  void resetData() {
    descriptionController.clear();
    locationController.clear();
    districtController.clear();

    descriptionError.value = null;
    locationError.value = null;
    districtError.value = null;

    selectedImages.clear();
    adviseContent.value = null;
  }

  void printDetails(String description, String location, String district, List<String> imageUrls) {
    print('Descripción: $description');
    print('Ubicación: $location');
    print('Distrito: $district');

    if (imageUrls.isNotEmpty) {
      print('Imágenes:');
      for (String url in imageUrls) {
        print(url);
      }
    } else {
      print('No hay imágenes.');
    }
  }
}
