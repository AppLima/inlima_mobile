import 'package:get/get.dart';
import 'package:inlima_mobile/models/usuario.dart';
import '../../models/queja.dart';
import '../../services/queja_service.dart';
import '../../_global_controllers/sesion_controller.dart';

class DetailController extends GetxController {
  QuejaService quejaService = QuejaService();
  var auxlist = <Queja>[].obs;
  var complaints = <Queja>[].obs;

  final SesionController sesionController = Get.find<SesionController>();

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    auxlist.value = await quejaService.fetchAll();

    int userId = sesionController.usuario.idUsuario;
    print(userId);

    complaints.value = auxlist.where((queja) => queja.usuarioId == userId).toList();

    if (complaints.isEmpty) {
      print("No complaints found for user $userId");
    }
  }
}