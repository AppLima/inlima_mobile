import 'package:get/get.dart';
import 'package:inlima_mobile/models/queja.dart';
import '../../services/queja_service.dart';
import '../../_global_controllers/sesion_controller.dart';

class ResultController extends GetxController {
  QuejaService quejaService = QuejaService();
  var auxlist = <Queja>[].obs;
  var complaints = <Queja>[].obs;
  var topics = <String>[].obs;

  ResultController(List<String> passedTopics) {
    topics.assignAll(passedTopics);
    listComplaints();
  }

  void listComplaints() async {
    auxlist.value = await quejaService.fetchAll();

    complaints.value = auxlist.where((queja) {
      return topics.any((topic) => queja.asunto == topic);
    }).toList();
  }
}
