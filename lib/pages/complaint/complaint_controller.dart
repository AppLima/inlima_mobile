import 'package:get/get.dart';
import '../../models/asunto.dart';
import '../../services/asunto_service.dart';

class ComplaintController extends GetxController {
  AsuntoService asuntoService = AsuntoService();
  var complaints = <Asunto>[].obs;

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    complaints.value = await asuntoService.fetchAll();
    //print(complaints.value);
  }
}
