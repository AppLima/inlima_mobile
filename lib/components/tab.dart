import 'package:flutter/material.dart';
import 'package:inlima_mobile/configs/colors.dart';

class Tabs extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  Tabs({
    required this.isLogin,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: AppColors.lightGreyInlima,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: Duration(milliseconds: 300),
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.38,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.tertiaryColorInlima,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onLoginTap,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        color: isLogin ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onRegisterTap,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                        color: !isLogin ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
