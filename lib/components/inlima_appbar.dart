import 'package:flutter/material.dart';
import '../configs/colors.dart';


class InLimaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InLimaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Image.asset(
        'assets/img_app/inLima_text.png',
        height: 60,
        fit: BoxFit.contain,
      ),
      backgroundColor: AppColors.tertiaryColorInlima,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
