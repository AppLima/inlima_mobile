import 'package:get/get.dart';
import '../../models/queja.dart';
import '../../services/queja_service.dart';

class ComplaintController extends GetxController {
  QuejaService quejaService = QuejaService();
  var complaints = <Queja>[].obs;

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    complaints.value = await quejaService.fetchAll();
    //print(complaints.value);
  }
}
