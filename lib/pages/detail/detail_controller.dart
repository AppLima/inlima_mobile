import 'package:get/get.dart';
import '../../models/queja.dart';
import '../../services/queja_service.dart';
import '../../_global_controllers/sesion_controller.dart';

class DetailController extends GetxController {
  QuejaService quejaService = QuejaService();
  var auxlist = <Queja>[].obs;
  var complaint = Rxn<Queja>();
  var id = Rxn<int>();  // Observable que puede ser nulo

  // Elimina el llamado a listComplaints del constructor
  DetailController(int index) {
    id.value = index;  // Asigna el valor al observable `id`
  }

  final SesionController sesionController = Get.find<SesionController>();

  void updateComplaint(int newId) {
    resetData();  // Limpia los datos anteriores
    id.value = newId;  // Asigna el nuevo ID
    listComplaint();  // Vuelve a listar la queja
  }

  void resetData() {
      auxlist.clear();
      id.value = null;
      listComplaint();
  }

  @override
  void onInit() {
    super.onInit();
    listComplaint();  // Solo llama a listComplaint en onInit
  }

  void listComplaint() async {
    print("detailcontrollador");
    print(id);
    auxlist.value = await quejaService.fetchAll();
    for (var aux in auxlist) {
      if (aux.id == id.value) {
        complaint.value = aux;
        break;
      }
    }

    if (complaint.value == null) {
      print("No complaint found.");
    }
  }
}
