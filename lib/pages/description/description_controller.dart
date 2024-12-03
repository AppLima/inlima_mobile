import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/advise_card.dart';
import '../../apis/complaint_api.dart';

class DescriptionController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  String subject = '';
  final complaintApi = ComplaintApi();
  
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

