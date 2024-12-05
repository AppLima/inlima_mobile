import 'package:get/get.dart';
import '../../models/queja.dart';
import '../../_global_controllers/sesion_controller.dart';

class DetailController extends GetxController {
  var complaint = Rxn<Queja>();
  final SesionController sesionController = Get.find<SesionController>();

  DetailController();

  void updateComplaint(Queja queja) {
    complaint.value = queja;
  }

  void resetData() {
    complaint.value = null;
  }
}
