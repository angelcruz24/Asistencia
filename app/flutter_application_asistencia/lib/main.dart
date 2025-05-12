import 'package:flutter/material.dart';

import 'package:flutter_application_asistencia/src/views/login.dart'; // Asegúrate que el nombre del archivo coincida

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Asistencia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(), // Esta es tu pantal)la de login
    );
  }
}
