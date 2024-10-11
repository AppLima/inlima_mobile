import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class DescriptionController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
    
  }

  // Función para subir múltiples imágenes
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
