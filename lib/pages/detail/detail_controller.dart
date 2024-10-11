import 'package:get/get.dart';
import '../../models/queja.dart';
import '../../services/queja_service.dart';
import '../../_global_controllers/sesion_controller.dart';

class DetailController extends GetxController {
  QuejaService quejaService = QuejaService();
  var auxlist = <Queja>[].obs;
  var complaint = Queja(
    id: 0,
    asunto: '',
    descripcion: '',
    ubicacion: '',
    fecha: '',
    estado: '',
    usuarioId: 0,
    fotos: []
  ).obs;
  var id = Rxn<int>();  // Observable que puede ser nulo

  // Elimina el llamado a listComplaints del constructor
  DetailController(int index) {
    id.value = index;  // Asigna el valor al observable `id`
  }

  final SesionController sesionController = Get.find<SesionController>();

  @override
  void onInit() {
    super.onInit();
    listComplaint();  // Solo llama a listComplaint en onInit
  }

  void listComplaint() async {
    auxlist.value = await quejaService.fetchAll();

    for (var aux in auxlist) {
      if (aux.id == id.value) {
        complaint.value = aux;
        break;
      }
    }

    if (complaint.value.id == 0) {
      print("No complaint found.");
    }
  }
}
