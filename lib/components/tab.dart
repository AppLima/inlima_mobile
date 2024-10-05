import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/configs/colors.dart';
import 'package:inlima_mobile/pages/login/inicio/inicio_controller.dart';

class Tabs extends StatelessWidget {
  final InicioController control = Get.find(); // Obtenemos la instancia del controlador

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreyInlima, // Fondo gris
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          Obx(() => AnimatedAlign(
                duration: Duration(milliseconds: 300),
                alignment: control.isLogin.value
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryColorInlima,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    control.isLogin.value = true; // Activamos el login
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: control.isLogin.value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    control.isLogin.value = false; // Activamos el registro
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Obx(() => Text(
                          'Registrarse',
                          style: TextStyle(
                            color: !control.isLogin.value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
