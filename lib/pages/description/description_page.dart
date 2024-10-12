import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../components/button_simple.dart';
import './description_controller.dart';
import '../../components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';
import 'package:get/get.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage({super.key});

  final DescriptionController _controller = Get.put(DescriptionController());
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _controller.selectedImages.add(File(pickedImage.path));
    }
  }

  Future<void> _selectPhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _controller.selectedImages.add(File(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final String? asunto = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      key: _scaffoldKey, 
      appBar: InLimaAppBar(
        isInPerfil: false,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: const LateralBar(),
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
              Obx(() => TextFormField(
                controller: _controller.descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Escribe la descripción aquí...',
                  errorText: _controller.descriptionError.value,
                ),
                maxLines: 3,
              )),
              const SizedBox(height: 16),
              const Text(
                'Ubicación:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(() => TextFormField(
                controller: _controller.locationController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Escribe la ubicación aquí...',
                  errorText: _controller.locationError.value,
                ),
              )),
              const SizedBox(height: 16),
              const Text(
                'Distrito del incidente:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(() => TextField(
                controller: _controller.districtController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Escriba el distrito del incidente aquí...',
                  errorText: _controller.districtError.value,
                ),
              )),
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
              Obx(() => _controller.selectedImages.isEmpty
                  ? const Text('No se han adjuntado fotos.')
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _controller.selectedImages.length,
                      itemBuilder: (context, index) {
                        //final imageFile = _controller.selectedImages[index];
                        return ListTile(
                          leading: const Icon(Icons.image),
                          title: Text('Foto ${index + 1}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _controller.selectedImages.removeAt(index),
                          ),
                        );
                      },
                    )),
              const SizedBox(height: 16),
              Obx(() => ButtonSimple(
                text: 'Enviar',
                enabled: true,
                adviseContent: _controller.adviseContent.value,
                onPressed: () async {
                  await _controller.enviar();
                },
                adviseRoute: _controller.adviseContent.value != null ? "/home" : null,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
