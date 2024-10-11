import 'package:flutter/material.dart';
import '../configs/colors.dart';

class InLimaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isInPerfil;

  const InLimaAppBar({super.key, this.isInPerfil = false});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    // Añade la verificación para la ruta "/result"
    final bool isInSpecialRoute = currentRoute == "/description" || currentRoute == "/result" || currentRoute == "/detail";

    print(currentRoute);

    return AppBar(
      backgroundColor: AppColors.primaryColorInlima,
      leading: isInSpecialRoute
          ? null
          : IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 40,
              color: AppColors.lightGreyInlima,
              onPressed: () {
                // Acción para abrir el menú
              },
            ),
      centerTitle: true,
      title: Image.asset(
        'assets/img_app/inlima_logo_nobg.png',
        height: 40,
        fit: BoxFit.contain,
      ),
      actions: [
        IconButton(
          icon: (isInPerfil || isInSpecialRoute)
              ? const Icon(Icons.close)
              : const Icon(Icons.account_circle),
          iconSize: 40,
          color: AppColors.lightGreyInlima,
          onPressed: () {
            if (isInPerfil || isInSpecialRoute) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, "/perfil");
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
