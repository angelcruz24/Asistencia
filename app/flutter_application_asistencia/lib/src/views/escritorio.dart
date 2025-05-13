import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/views/entrada.dart';
import 'package:flutter_application_asistencia/src/views/login.dart';
import 'package:flutter_application_asistencia/src/views/salida.dart'; 

class Escritorio extends StatelessWidget {
  final String nombreUsuario;

  const Escritorio({super.key, required this.nombreUsuario});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "BIENVENIDO",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "USUARIO:",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                enabled: false,
                controller: TextEditingController(text: nombreUsuario),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 30),

              // Botón REGISTRAR ENTRADA
              Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entrada(nombreUsuario: nombreUsuario)),
                );
              }),
              const SizedBox(height: 20),

              // Botón REGISTRAR SALIDA
              Estilosbotones.btnwarning("REGISTRAR SALIDA", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Salida(nombreUsuario: nombreUsuario)),
                );// Acción para registrar salida
              }),
              const SizedBox(height: 20),

              // Botón SALIR DE LA APP
              Estilosbotones.btnlight("SALIR DE LA APP", () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                ); // Acción para salir de la app
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Piedepagina(),
    );
  }
}

