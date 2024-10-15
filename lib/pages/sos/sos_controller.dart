import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSController extends GetxController {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el marcador telefónico para $phoneNumber';
    }
  }
}
