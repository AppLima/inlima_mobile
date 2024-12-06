import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/apis/complaint_api.dart';
import '../../models/queja.dart';

class DetailController extends GetxController {
  // Queja seleccionada
  var complaint = Rxn<Queja>();
  
  // Estado inicial para comparar cambios
  var initState = RxnString();
  
  // Controlador de sesión
  final SesionController sesionController = Get.find<SesionController>();
  ComplaintApi complaintApi = ComplaintApi();

  DetailController();

  // Actualiza la queja y establece el estado inicial
  void updateComplaint(Queja queja) {
    complaint.value = queja;
    initState.value = queja.estado; // Guarda el estado inicial para futuras comparaciones
  }

  // Resetea los datos de la queja y el estado inicial
  void resetData() {
    complaint.value = null;
    initState.value = null;
  }

  // Método para actualizar el estado actual de la queja
  void updateState(String newState) {
    if (complaint.value != null) {
      complaint.update((val) {
        val?.estado = newState; // Cambia el estado de la queja actual
      });
    }
  }

  // Método para comprobar si el estado actual es diferente del inicial
  bool hasStateChanged() {
    return complaint.value?.estado != initState.value;
  }

  // Llama a la API para actualizar el estado de la queja
  Future<void> updateComplaintStatus() async {
    print("UPDATING STATUS PAGE CONTROLLER");
    if (complaint.value == null) {
      print('No hay una queja seleccionada para actualizar.');
      return;
    }

    if (!hasStateChanged()) {
      print('El estado no ha cambiado. No se requiere actualización.');
      return;
    }

    try {
      final result = await complaintApi.updateComplaintStatus(
        complaint.value!.id,
        estadoToId(complaint.value!.estado),
      );

      if (result == true) {
        print('Estado de la queja actualizado correctamente.');
        initState.value = complaint.value!.estado; // Actualiza el estado inicial
      } else {
        print('Error al actualizar el estado de la queja.');
      }
    } catch (e) {
      print('Error al intentar actualizar el estado: $e');
    }
  }

  // Convierte el estado a su ID correspondiente (mapeo según tu backend)
  int estadoToId(String? estado) {
    switch (estado) {
      case 'En proceso':
        return 1;
      case 'Archivado':
        return 2;
      case 'Finalizado':
        return 3;
      default:
        throw Exception('Estado no válido: $estado');
    }
  }
}

