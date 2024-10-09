import 'package:flutter/material.dart';
import '../configs/colors.dart';

class InLimaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InLimaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          icon: const Icon(Icons.account_circle),
          iconSize: 40,
          color: AppColors.lightGreyInlima,
          onPressed: () {
            // Acción del ícono de usuario
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
