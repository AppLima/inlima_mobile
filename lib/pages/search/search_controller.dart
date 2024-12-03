import 'package:get/get.dart';
import '../../models/asunto.dart';
import '../../services/asunto_service.dart';
import '../../apis/subject_api.dart'; 

class SearchCController extends GetxController {
  AsuntoService quejaService = AsuntoService();
  var complaints = <Asunto>[].obs;
  final subjectApi = SubjectApi();
  var selectedComplaints = <Asunto>[].obs;

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
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

  void toggleComplaintSelection(Asunto complaint) {
    if (selectedComplaints.contains(complaint)) {
      selectedComplaints.remove(complaint);
    } else {
      selectedComplaints.add(complaint);
    }
  }

  void resetData() {
    selectedComplaints.clear();
  }

  void selectAllComplaints() {
    selectedComplaints.clear();
    selectedComplaints.addAll(complaints);
  }

  void deselectAllComplaints() {
    selectedComplaints.clear();
  }

  bool areAllSelected() {
    return complaints.length == selectedComplaints.length;
  }
}

