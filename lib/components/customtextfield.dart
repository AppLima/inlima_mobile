import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? toggleVisibility; // Función para alternar visibilidad
  final bool? isPassword; // Indica si es un campo de contraseña

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.inputType,
    this.obscureText = false,
    this.icon,
    this.toggleVisibility,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null
              ? Icon(icon, color: isDarkMode ? Colors.white70 : Colors.grey)
              : null,
          suffixIcon: isPassword == true
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: isDarkMode ? Colors.white70 : Colors.grey,
                  ),
                  onPressed: toggleVisibility, // Llamada para alternar visibilidad
                )
              : null,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[850] : Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelStyle: TextStyle(
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
