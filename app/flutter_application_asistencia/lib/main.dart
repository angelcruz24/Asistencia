import 'package:flutter/material.dart';

import 'package:flutter_application_asistencia/src/views/iniciodesesion.dart'; // Asegúrate que el nombre del archivo coincida

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
      home: const LoginPage(title: 'Asistencias',), // Esta es tu pantalla de login
    );
  }
}
