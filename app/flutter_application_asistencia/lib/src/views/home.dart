import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';


class Bienvenido extends StatelessWidget {
  const Bienvenido({super.key});
  

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

              // Etiqueta USUARIO:
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "USUARIO:",
                  style: TextStyle(fontSize: 14),
                ),
              ),

              // Caja de texto (deshabilitada)
              const SizedBox(height: 5),
              const TextField(
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),

              const SizedBox(height: 30),

              // Botón Registrar Entrada (verde)
              Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () {
                // Acción para registrar entrada
              }),
              const SizedBox(height: 20),

              // Botón Registrar Salida (amarillo)
              Estilosbotones.btnwarning("REGISTRAR SALIDA", () {
                // Acción para registrar salida
              }),
              const SizedBox(height: 20),

              // Botón Salir (blanco)
              Estilosbotones.btnlight("SALIR DE LA APP", () {
                // Acción para salir de la app
              }),
            ],
          ),
        ),
      ),
    );
  }
}
