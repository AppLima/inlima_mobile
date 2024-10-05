import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../components/inlima_appbar.dart';
import '../../components/button_simple.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImages.add(File(pickedImage.path));
      });
    }
  }

  Future<void> _selectPhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImages.add(File(pickedImage.path));
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recibe el asunto pasado como argumento
    final String? asunto = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: const InLimaAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Muestra el asunto como el título de la pantalla
              Text(
                asunto ?? 'Descripción',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
              
              const SizedBox(height: 16),
              _selectedImages.isEmpty
                  ? const Text('No se han adjuntado fotos.')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        final imageFile = _selectedImages[index];
                        return ListTile(
                          leading: const Icon(Icons.image),
                          title: Text('Foto ${index + 1}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removePhoto(index),
                          ),
                        );
                      },
                    ),
              
              const SizedBox(height: 16),
              ButtonSimple(
                text: 'Enviar',
                enabled: true,
                adviseContent: 'Queja enviada con éxito',
                onPressed: () {
                  print('Botón Enviar presionado');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
