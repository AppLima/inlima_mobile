import 'package:flutter/material.dart';
import 'package:inlima_mobile/configs/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.feedback),
          label: 'Quejas/Sugerencias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.warning),
          label: 'SOS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.poll),
          label: 'Sondeos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historial',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: AppColors.primaryColorInlima, // Color del ítem seleccionado
      unselectedItemColor: AppColors.lightGreyInlima, // Color de los ítems no seleccionados
      backgroundColor: AppColors.blackInlima, // Color de fondo
      onTap: onItemTapped, // Cambiar de pestaña al hacer clic
    );
  }
}
