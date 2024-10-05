import 'package:get/get.dart';
import 'package:inlima_mobile/models/sondeo.dart';
import 'package:inlima_mobile/services/survey_service.dart';

class SurveyController extends GetxController{
  SondeoService sondeoService = SondeoService();
  var sondeos = <Sondeo>[].obs;
  var sondeosDisponibles = <Sondeo>[].obs;

  void fetchSondeos() async {
    sondeos.value = await sondeoService.fetchAll();
  }

  void fetchSondeosDisponibles() async {
    sondeosDisponibles.value = await sondeoService.fetchSondeosDisponibles();
  }

  @override
  void onInit() {
    super.onInit();
    fetchSondeosDisponibles();
  }
}