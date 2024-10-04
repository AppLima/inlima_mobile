import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../components/inlima_appbar.dart';
import '../../components/button_simple.dart'; // Importar tu botón personalizado

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = []; // Lista para almacenar las imágenes seleccionadas

  // Función para tomar una foto con la cámara
  Future<void> _takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImages.add(File(pickedImage.path)); // Añadir la imagen a la lista
      });
    }
  }

  // Función para seleccionar una imagen desde la galería
  Future<void> _selectPhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImages.add(File(pickedImage.path)); // Añadir la imagen a la lista
      });
    }
  }

  // Función para eliminar una imagen seleccionada
  void _removePhoto(int index) {
    setState(() {
      _selectedImages.removeAt(index); // Remover la imagen de la lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InLimaAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe la descripción aquí...',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Ubicación:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe la ubicación aquí...',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Distrito del incidente:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escriba el distrito del incidente aquí...',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Adjuntar foto:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              
              // Botones para tomar o seleccionar fotos
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _takePhoto,
                    child: const Text('Tomar foto'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _selectPhoto,
                    child: const Text('Seleccionar foto'),
                  ),
                ],
              ),
              
              // Mostrar la lista de fotos seleccionadas o tomadas
              const SizedBox(height: 16),
              _selectedImages.isEmpty
                  ? const Text('No se han adjuntado fotos.')
                  : ListView.builder(
                      shrinkWrap: true, // Hace que el ListView se ajuste a su contenido
                      physics: const NeverScrollableScrollPhysics(), // Evita que el ListView se desplace
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        final imageFile = _selectedImages[index];
                        return ListTile(
                          leading: Icon(Icons.image),
                          title: Text('Foto ${index + 1}'), // Nombre de la foto
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removePhoto(index), // Eliminar la foto
                          ),
                        );
                      },
                    ),
              
              const SizedBox(height: 16),
              ButtonSimple(
                text: 'Enviar',
                enabled: true, // Habilitar el botón
                adviseContent: 'Queja enviada con éxito', // Mensaje del aviso
                onPressed: () {
                  print('Botón Enviar presionado');
                  // No se navega a ninguna parte por ahora
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}