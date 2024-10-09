import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class ConfiBiometricaController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  var canCheckBiometrics = false.obs;
  var availableBiometrics = <BiometricType>[].obs;
  var authorized = "No autenticado".obs;
  var isAuthenticating = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkBiometrics();
    getAvailableBiometrics();
  }

  // Verifica si la biometría está disponible en el dispositivo
  Future<void> checkBiometrics() async {
    bool canCheck;
    try {
      canCheck = await auth.canCheckBiometrics;
    } catch (e) {
      canCheck = false;
    }
    canCheckBiometrics.value = canCheck;
  }

  // Obtiene los tipos de biometría disponibles en el dispositivo
  Future<void> getAvailableBiometrics() async {
    List<BiometricType> biometrics;
    try {
      biometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      biometrics = <BiometricType>[];
    }
    availableBiometrics.value = biometrics;
  }

  // Autenticación biométrica
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      isAuthenticating.value = true;
      authorized.value = 'Autenticando...';
      authenticated = await auth.authenticate(
        localizedReason: 'Por favor, autentícate usando tu biometría',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      isAuthenticating.value = false;
      authorized.value = authenticated ? 'Autenticado' : 'Fallo la autenticación';
    } catch (e) {
      isAuthenticating.value = false;
      authorized.value = 'Error: $e';
    }
  }
}