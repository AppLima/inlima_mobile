import 'package:get/get.dart';
import '../../models/queja.dart';
import '../../services/queja_service.dart';

class SearchCController extends GetxController {
  QuejaService quejaService = QuejaService();
  var complaints = <Queja>[].obs;
  var selectedComplaints = <Queja>[].obs;

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    complaints.value = await quejaService.fetchAll();
  }

  void toggleComplaintSelection(Queja complaint) {
    if (selectedComplaints.contains(complaint)) {
      selectedComplaints.remove(complaint);
    } else {
      selectedComplaints.add(complaint);
    }
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

