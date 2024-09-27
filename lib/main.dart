import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InLima',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      
        home: Scaffold(
          appBar: AppBar(title: Text('Inlima')),
          body: Text("Hola mundo"),
        )

      //initialRoute: '/sign-in',

      //routes: {
        //'/home':  (context) => HomePage(),
        //'/sign-in': (context) => SignInPage(),
        //'/sign-up': (context) => SignUpPage(),
        //'/reset': (context) => ResetPage(),
      //};
    );
  }
}