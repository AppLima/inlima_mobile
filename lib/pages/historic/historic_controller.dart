import 'package:get/get.dart';
import '../../models/queja.dart';
import '../../services/queja_service.dart';
import '../../_global_controllers/sesion_controller.dart';
import '../../apis/complaint_api.dart';

class HistoricController extends GetxController {
  ComplaintApi quejaService = ComplaintApi();
  var auxlist = <Queja>[].obs;
  var complaints = <Queja>[].obs;
  var isLoading = true.obs;

  final SesionController sesionController = Get.find<SesionController>();

  @override
  void onInit() {
    super.onInit();
    listComplaints();
  }

  void listComplaints() async {
    try {
      final response = await quejaService.getUserComplaints();
      print(response);
      if (response != null){
        complaints.value = response;
        print("Holaaa<aaassaa");
        print(complaints.value);
      }else{
        print("Error al obtener las quejas");
      }
    } catch(e){
      print("Error al hacer algo xd");
    }

    if (complaints.isEmpty) {
      isLoading(false);
      //print("No complaints found for user $userId");
    }
  }
}
