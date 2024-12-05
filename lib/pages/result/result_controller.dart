import 'package:get/get.dart';
import 'package:inlima_mobile/models/queja.dart';
import '../../services/queja_service.dart';
import '../../apis/complaint_api.dart';

class ResultController extends GetxController {
  ComplaintApi quejaService = ComplaintApi();
  var auxlist = <Queja>[].obs;
  var complaints = <Queja>[].obs;
  final topics = <int>[].obs;
  final topicNames = <String>[].obs; // Opcional: nombres
  var isLoading = true.obs;

  ResultController(List<Map<String, dynamic>> passedTopics) {
    topics.assignAll(passedTopics.map((e) => e['id'] as int).toList());
    topicNames.assignAll(passedTopics.map((e) => e['name'] as String).toList());
    listComplaints();
  }
  void onInit() {
    super.onInit();
    auxlist.clear();
    topics.clear();
    topicNames.clear();
    complaints.clear();
  }

  void resetData() {
      auxlist.clear();
      topics.clear();
      topicNames.clear();
      complaints.clear();
      isLoading.value = false;
  }

  void listComplaints() async {
    try {
      isLoading(true);
      final response = await quejaService.getFilteredComplaints(topics);
      print(response);
      if (response != null){
        complaints.value = response;
      }else{
        print("Error al obtener las quejas");
      }
    } catch(e){
      print("Error al hacer algo");
    } finally {
      isLoading(false); // Asegúrate de detener el loading siempre
    }
  }

}
