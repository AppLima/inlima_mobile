import 'package:get/get.dart';
import 'package:inlima_mobile/apis/response_api.dart';
import 'package:inlima_mobile/models/service_http_response.dart';
import 'package:inlima_mobile/models/respuesta.dart';

class SurveyDescriptionController extends GetxController {
  ResponseService responseService = ResponseService();

  Future<void> enviarRespuesta(Respuesta respuesta) async {
    try {
      // Convertir el objeto Respuesta a un Map<String, dynamic>
      final respuestaMap = {
        'id': respuesta.idRespuesta,
        'nombre': respuesta.nombre,
        'option': respuesta.opcion ? 1 : 0, // Convertir bool a entero
        'citizen_id': respuesta.idCiudadano,
        'survey_id': respuesta.idSondeo,
      };

      // Enviar la respuesta al servidor
      final ServiceHttpResponse? result =
          await responseService.recordResponse(respuestaMap);

      if (result != null) {
        print("======== Respuesta registrada correctamente: ${result}");
      } else {
        print("===== Error al registrar la respuesta.");
      }
    } catch (e) {
      print("========== Error en enviarRespuesta: $e");
    }
  }
}
