import 'package:flutter/material.dart';
import 'package:inlima_mobile/models/sondeo.dart';
import 'package:inlima_mobile/pages/home/home_page.dart';
import 'package:inlima_mobile/pages/login/inicio/inicio_page.dart';
import 'package:inlima_mobile/pages/login/pagina_principal/pagina_principal.dart';
import 'package:inlima_mobile/pages/survey/survey.dart';
import 'package:inlima_mobile/pages/survey_description/survey_description.dart';
import 'pages/complaint/complaint_page.dart';
import 'pages/description/description_page.dart';
import 'configs/app_theme.dart';
import 'package:inlima_mobile/models/usuario.dart';

void main() {
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

      initialRoute: '/login/pagina_principal',
      //initialRoute: '/survey',

      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final Usuario usuario = settings.arguments as Usuario;

          return MaterialPageRoute(
            builder: (context) {
              return HomePage(usuario: usuario);
            },
          );
        }
        if (settings.name == '/survey_description') {
          final Sondeo sondeo = settings.arguments as Sondeo;
          return MaterialPageRoute(
            builder: (context) {
             return SurveyDescription(sondeo: sondeo);
            },
          );
        }
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case '/login/inicio':
                return InicioPage(isRegister: false);
              case '/login/pagina_principal':
                return PaginaPrincipalPage();
              case '/complaint':
                return ComplaintPage();
              case '/description':
                return const DescriptionPage();
              case '/survey':
                return SurveyPage();
              default:
                return const Scaffold(
                  body: Center(child: Text('Ruta no encontrada')),
                );
            }
          },
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:inlima_mobile/pages/login/inicio/inicio_page.dart';
// import 'package:inlima_mobile/pages/login/pagina_principal/pagina_principal.dart';
// import 'pages/complaint/complaint_page.dart';
// import 'pages/description/description_page.dart';
// import 'configs/app_theme.dart';

// void main(){
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'InLima',

//       theme: AppTheme.lightTheme(), // Tema claro
//       darkTheme: AppTheme.darkTheme(), // Tema oscuro
//       themeMode: ThemeMode.system,
//       /*
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//         useMaterial3: true,
//       ),*/
      
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Inlima')),
//       ),

//       initialRoute: '/login/pagina_principal',
      
//       routes: {
//         //'/home':  (context) => HomePage(),
//         //'/sign-in': (context) => SignInPage(),
//         //'/sign-up': (context) => SignUpPage(),
//         //'/reset': (context) => ResetPage(),
//         '/complaint': (context) => ComplaintPage(),
//         '/description': (context) => DescriptionPage(),
//         '/login/inicio': (context) => InicioPage(isRegister: false),
//         '/login/pagina_principal': (context) => PaginaPrincipalPage(),
//         '/home': (context) => HomePage(),
//       }
//     );
//   }
// }