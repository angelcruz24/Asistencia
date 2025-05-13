import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/views/escritorio.dart';

import 'package:flutter_application_asistencia/src/views/login.dart';
//import 'package:flutter_application_asistencia/src/views/salida.dart'; // Asegúrate que el nombre del archivo coincida

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
      home: const Escritorio(), // Esta es tu pantal)la de login
    );
  }
}
