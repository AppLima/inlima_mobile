import 'package:flutter/material.dart';
import 'pages/complaint/complaint_page.dart';
import 'pages/description/description_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InLima',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      
      home: Scaffold(
        appBar: AppBar(title: const Text('Inlima')),
      ),

      initialRoute: '/description',
      
      routes: {
        //'/home':  (context) => HomePage(),
        //'/sign-in': (context) => SignInPage(),
        //'/sign-up': (context) => SignUpPage(),
        //'/reset': (context) => ResetPage(),
        '/complaint': (context) => ComplaintPage(),
        '/description': (context) => DescriptionPage(),
      }
    );
  }
}