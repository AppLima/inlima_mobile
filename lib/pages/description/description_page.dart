import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './description_controller.dart';
import '../../components/inlima_appbar.dart';
import '../../components/lateral_bar.dart';
import 'package:get/get.dart';
import '../../configs/colors.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage({super.key});

  final DescriptionController _controller = Get.put(DescriptionController());
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _selectPhotoOrTakePhoto(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () async {
                  final pickedImage = await _picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    _controller.selectedImages.add(File(pickedImage.path));
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar desde galería'),
                onTap: () async {
                  final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    _controller.selectedImages.add(File(pickedImage.path));
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? asunto = ModalRoute.of(context)?.settings.arguments as String?;
    if (asunto is String) {
      _controller.subject = asunto;
    } else {
      _controller.subject = '';
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: InLimaAppBar(
        isInPerfil: false,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: const LateralBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      asunto ?? 'Descripción',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
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
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => TextFormField(
                          controller: _controller.locationController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Escribe la ubicación aquí...',
                            errorText: _controller.locationError.value,
                          ),
                        )),
                      ),
                      IconButton(
                        icon: const Icon(Icons.my_location, color: Colors.blue),
                        onPressed: () => _controller.getCurrentLocation(),
                      ),
                    ],
                  ),
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
                  ElevatedButton.icon(
                    onPressed: () => _selectPhotoOrTakePhoto(context),
                    icon: const Icon(Icons.photo_camera, color: Colors.white),
                    label: const Text('Adjuntar foto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => _controller.selectedImages.isEmpty
                      ? const Text('No se han adjuntado fotos.')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _controller.selectedImages.length,
                          itemBuilder: (context, index) {
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
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _controller.enviar(context);
                    },
                    icon: const Icon(Icons.send, color: Colors.black),
                    label: const Text(
                      'Enviar',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColorInlima,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (_controller.isLoading.value) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
