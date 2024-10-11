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

  void resetData() {
      auxlist.clear();
      topics.clear();
      listComplaints();
  }

  void listComplaints() async {
    print('Topics: $topics'); // Para depuración: Verifica qué temas se están recibiendo

    auxlist.value = await quejaService.fetchAll();
    print('Auxlist quejas: $auxlist'); // Para depuración: Verifica qué quejas se han obtenido

    // Verifica si los asuntos coinciden con los temas de manera robusta
    complaints.value = auxlist.where((queja) {
      return topics.any((topic) => queja.asunto.toLowerCase().trim() == topic.toLowerCase().trim());
    }).toList();

    print('Filtered complaints: $complaints'); // Para depuración: Verifica qué quejas pasan el filtro
  }

}
