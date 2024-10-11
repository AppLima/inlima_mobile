import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/pages/perfil/perfil_controller.dart';
import 'package:inlima_mobile/pages/description/description_controller.dart';
import 'package:inlima_mobile/pages/result/result_controller.dart';
import 'package:inlima_mobile/pages/detail/detail_controller.dart';
import 'package:inlima_mobile/pages/search/search_controller.dart';
import 'package:inlima_mobile/configs/colors.dart';
// Importa el SesionController

class InLimaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isInPerfil; // Parámetro para controlar si está en la página de perfil
  final GlobalKey<ScaffoldState> scaffoldKey; 
  
  const InLimaAppBar({super.key, this.isInPerfil = false, required this.scaffoldKey}); // Constructor con el parámetro

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    // Añade la verificación para la ruta "/description", "/result" y "/detail"
    final bool isInSpecialRoute = currentRoute == "/description" || currentRoute == "/result" || currentRoute == "/detail";

    // Obtén el controlador de sesión
    final SesionController sesionController = Get.find<SesionController>();

    // Verifica si el usuario es administrador
    bool isAdmin = sesionController.usuario.rolId == 1; // Cambia el valor de rolId que corresponde a "admin" según tu lógica

    return AppBar(
      backgroundColor: AppColors.primaryColorInlima, // Color de fondo del AppBar
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 40,
        color: AppColors.lightGreyInlima,
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      centerTitle: true,
      title: Image.asset(
        'assets/img_app/inlima_logo_nobg.png',
        height: 40,
        fit: BoxFit.contain,
      ),
      actions: [
        // Si no es admin, mostrar el botón de perfil o el botón de cerrar en rutas especiales
        if (!isAdmin) 
          IconButton(
            icon: (isInPerfil || isInSpecialRoute) ? const Icon(Icons.close) : const Icon(Icons.account_circle),
            iconSize: 40,
            color: AppColors.lightGreyInlima,
            onPressed: () {
              if (isInPerfil || isInSpecialRoute) {
                _showExitConfirmationDialog(context, currentRoute);
              } else {
                Navigator.pushNamed(context, "/perfil");
              }
            },
          ),
      ],
    );
  }

  void _showExitConfirmationDialog(BuildContext context, String? currentRoute) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Seguro que quieres salir sin actualizar?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sí'),
              onPressed: () {
                if (currentRoute == "/perfil") {
                  final perfilController = Get.find<PerfilController>();
                  perfilController.resetPerfilData();
                } else if (currentRoute == "/description") {
                  final descriptionController = Get.find<DescriptionController>();
                  descriptionController.resetData();
                } else if (currentRoute == "/result") {
                  final resultController = Get.find<ResultController>();
                  resultController.resetData();
                  final searchCController = Get.find<SearchCController>();
                  searchCController.resetData();
                } else if (currentRoute == "/detail") {
                  final detailController = Get.find<DetailController>();
                  detailController.resetData();
                }

                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
