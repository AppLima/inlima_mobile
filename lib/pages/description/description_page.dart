import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../components/inlima_appbar.dart';
import '../../components/button_simple.dart';
import './description_controller.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  final DescriptionController _controller = DescriptionController();

  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _districtController = TextEditingController();

  String? _descriptionError;
  String? _locationError;
  String? _districtError;
  String? _adviseContent;

  Future<void> _enviar() async {

    bool isValid = false;

    setState(() {
      isValid = _validateFields();
    });

    if (isValid) {
      List<String> downloadUrls = [];

      if (_selectedImages.isNotEmpty) {
        downloadUrls = await _controller.uploadImages(_selectedImages);
      }

      final description = _descriptionController.text.trim();
      final location = _locationController.text.trim();
      final district = _districtController.text.trim();
      _controller.printDetails(description, location, district, downloadUrls);

      setState(() {
        _adviseContent = "Queja enviada con éxito";
      });
    }
  }

  String? _getAdviseContent() {
    return _adviseContent;
  }

  String? _getAdviseRoute() {
    return _adviseContent != null ? "/complaint" : null;
  }

  bool _validateFields() {
    final description = _descriptionController.text.trim();
    final location = _locationController.text.trim();
    final district = _districtController.text.trim();

    setState(() {
      _descriptionError = description.isEmpty ? 'Por favor ingrese una descripción.' : null;
      _locationError = location.isEmpty ? 'Por favor ingrese una ubicación.' : null;
      _districtError = district.isEmpty ? 'Por favor ingrese el distrito.' : null;
    });

    return _descriptionError == null && _locationError == null && _districtError == null;
  }

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
    final String? asunto = ModalRoute.of(context)?.settings.arguments as String?;
    print(asunto);

    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Escribe la descripción aquí...',
                  errorText: _descriptionError,
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
                controller: _locationController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Escribe la ubicación aquí...',
                  errorText: _locationError,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Distrito del incidente:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _districtController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Escriba el distrito del incidente aquí...',
                  errorText: _districtError,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Adjuntar foto:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
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
                adviseContent: _getAdviseContent(),
                onPressed: () async {
                  await _enviar();
                },
                adviseRoute: _getAdviseRoute(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
