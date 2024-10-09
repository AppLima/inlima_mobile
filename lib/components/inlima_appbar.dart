import 'package:flutter/material.dart';
import '../configs/colors.dart';

class InLimaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isInPerfil; // Parámetro para controlar si está en la página de perfil

  const InLimaAppBar({super.key, this.isInPerfil = false}); // Constructor con el parámetro

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColorInlima, // Color de fondo del AppBar
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 40,
        color: AppColors.lightGreyInlima,
        onPressed: () {
          // Acción para desplegar el menú
        },
      ),
      centerTitle: true, // Centra el título en el AppBar
      title: Image.asset(
        'assets/img_app/inlima_logo_nobg.png',
        height: 40,
        fit: BoxFit.contain,
      ),
      actions: [
        IconButton(
          icon: isInPerfil ? const Icon(Icons.close) : const Icon(Icons.account_circle), // Cambia entre la X o el ícono de perfil
          iconSize: 40,
          color: AppColors.lightGreyInlima,
          onPressed: () {
            if (isInPerfil) {
              Navigator.pop(context); // Si está en perfil, vuelve a la página anterior
            } else {
              Navigator.pushNamed(context, "/perfil"); // Si no, navega al perfil
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
