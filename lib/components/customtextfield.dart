import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final IconData? icon;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.inputType,
    this.obscureText = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usamos el tema actual para adaptar el diseño al modo claro/oscuro
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // Aquí añadimos una sombra más prominente para cada tema
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4), // Desplazamiento sutil de la sombra
          ),
        ],
        borderRadius: BorderRadius.circular(12), // Mantén las esquinas redondeadas
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null
              ? Icon(icon, color: isDarkMode ? Colors.white70 : Colors.grey)
              : null, // Icono que cambia con el tema
          filled: true,
          fillColor: isDarkMode
              ? Colors.grey[850] // Fondo más oscuro en modo oscuro
              : Colors.white,     // Fondo blanco en modo claro
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        style: TextStyle(
          color: isDarkMode
              ? Colors.white
              : Colors.black, // Texto cambia según el tema
        ),
      ),
    );
  }
}
