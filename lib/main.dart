import 'package:flutter/material.dart';
import 'package:inlima_mobile/models/sondeo.dart';
import 'package:inlima_mobile/pages/confi_biometrica/confi_biometrica_page.dart';
import 'package:inlima_mobile/pages/home/home_page.dart';
import 'package:inlima_mobile/pages/login/inicio/inicio_page.dart';
import 'package:inlima_mobile/pages/login/pagina_principal/pagina_principal.dart';
import 'package:inlima_mobile/pages/perfil/perfil_page.dart';
import 'package:inlima_mobile/pages/survey/survey.dart';
import 'package:inlima_mobile/pages/survey_creation/survey_creation.dart';
import 'package:inlima_mobile/pages/survey_description/survey_description.dart';
import 'pages/search/search_page.dart';
import 'pages/complaint/complaint_page.dart';
import 'pages/description/description_page.dart';
import 'configs/app_theme.dart';
import 'package:inlima_mobile/models/usuario.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InLima',
      theme: AppTheme.lightTheme(), // Tema claro
      darkTheme: AppTheme.darkTheme(), // Tema oscuro
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: const Text('Inlima')),
      ),
      initialRoute: '/search',
      routes: {
        '/login/pagina_principal': (context) => PaginaPrincipalPage(),
        '/login/inicio': (context) => InicioPage(isRegister: false), //login - register
        '/home':  (context) => HomePage(),
        '/confi_biometrica':  (context) => ConfiBiometricaPage(),
        '/perfil':  (context) => PerfilPage(),
        '/complaint': (context) => ComplaintPage(), //Pantalla de quejas
        '/description': (context) => const DescriptionPage(), //Realizar queja
        '/survey': (context) => SurveyPage(), //Sondeos disponibles
        '/survey_description' : (context) => SurveyDescription(),//Detalles de sondeo
        '/survey_creation' : (context) => SurveyCreationPage(),//Crear sondeo (Admin)
        '/search' : (context) => SearchPage(),
      },
    );
  }
}
