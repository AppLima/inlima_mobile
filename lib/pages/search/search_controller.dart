import 'package:get/get.dart';
import '../../models/asunto.dart';
import '../../services/asunto_service.dart';

class SearchCController extends GetxController {
  AsuntoService quejaService = AsuntoService();
  var complaints = <Asunto>[].obs;
  var selectedComplaints = <Asunto>[].obs;

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    complaints.value = await quejaService.fetchAll();
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

