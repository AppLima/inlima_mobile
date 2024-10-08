import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/_global_controllers/sesion_controller.dart';
import 'package:inlima_mobile/pages/complaint/complaint_page.dart';
import 'package:inlima_mobile/pages/survey/survey.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final SesionController sesion = Get.find<SesionController>();
  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Bienvenido, ${sesion.usuario.nombre}'),
      leadingWidth: 70,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/img_app/inlima_logo_nobg.png',
          height: 20, 
          width: 20,   
          fit: BoxFit.contain,
        ),
      ),
    ),
    body: Column(
      children: [
        Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SurveyPage()),
            );
          },
          child: const Text('Ir a Sondeos Disponibles'),
        ),
      ),
      Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ComplaintPage()),
            );
          },
          child: const Text('Realizar una queja'),
        ),
      ),
      ],
    )
  );
}

}
