import 'package:get/get.dart';
import '../../models/asunto.dart';
import '../../services/asunto_service.dart';
import '../../apis/subject_api.dart';

class ComplaintController extends GetxController {
  AsuntoService asuntoService = AsuntoService();
  final subjectApi = SubjectApi();
  var complaints = <Asunto>[].obs;

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    //complaints.value = await asuntoService.fetchAll();
    //print(complaints.value);
    try {
      final response = await subjectApi.getSubjects();
      if (response != null) {
        complaints.value = response;
      } else {
        print("Error al obtener temas");
      }
    } catch (e) {
      print("Error en fetchSubjects: $e");
  }
  }
}
