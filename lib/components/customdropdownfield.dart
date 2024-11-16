import 'package:flutter/material.dart';
import 'package:inlima_mobile/models/distrito.dart'; // Importa tu modelo Distrito

class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final Distrito? selectedValue;
  final List<Distrito> items;
  final ValueChanged<Distrito?> onChanged;
  final IconData? icon;

  const CustomDropdownField({
    Key? key,
    required this.labelText,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.icon,
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
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    icon,
                    color: isDarkMode ? Colors.white70 : Colors.grey,
                  ),
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
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Distrito>(
            value: selectedValue, // Esto debe ser de tipo Distrito
            hint: Text("Selecciona tu distrito"),
            items: items
                .map((distrito) => DropdownMenuItem<Distrito>(
                      value:
                          distrito, // Asegúrate de que el valor sea el objeto Distrito completo
                      child: Text(
                          distrito.name), // Mostrar el nombre del distrito
                    ))
                .toList(), // Convierte a una lista de DropdownMenuItem<Distrito>
            onChanged: onChanged, // Aquí llamas a la función de cambio
            icon: Icon(
              Icons.arrow_drop_down,
              color: isDarkMode ? Colors.white70 : Colors.grey,
            ),
            dropdownColor: isDarkMode ? Colors.grey[850] : Colors.white,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
