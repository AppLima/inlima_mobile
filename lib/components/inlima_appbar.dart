import 'package:flutter/material.dart';
import '../configs/colors.dart';


class InLimaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InLimaAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Image.asset(
        'assets/img_app/inlima_logo.png',
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
