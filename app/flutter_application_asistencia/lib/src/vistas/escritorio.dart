// escritorio.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/servicios/funciones.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/entrada.dart';
import 'package:flutter_application_asistencia/src/vistas/login.dart';
import 'package:flutter_application_asistencia/src/vistas/salida.dart';


class escritorio extends StatelessWidget {
  final String nombreusuario;

  const escritorio({super.key, required this.nombreusuario});

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
                controller: TextEditingController(text: nombreusuario),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              const SizedBox(height: 30),

              // Botón REGISTRAR ENTRADA
              Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () async {
                final idusuario = await obtenerusuarioid();
                final fechahora = await obtenerfechahora();
                final fecha = fechahora['fecha'] ?? '';

                if (idusuario == null || fecha.isEmpty) {
                  mensajeescritorio(context, 'Error', 'No se pudo obtener el ID de usuario o la fecha');
                  return;
                }

                final yatieneentrada = await consultarentrada(idusuario: idusuario, fecha: fecha);

                if (yatieneentrada) {
                  mensajeescritorio(context, 'Entrada ya registrada', 'Ya has registrado tu entrada hoy.');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => entrada(nombreusuario: nombreusuario)),
                  );
                }
              }),
              const SizedBox(height: 20),

              // Botón REGISTRAR SALIDA
              Estilosbotones.btnwarning("REGISTRAR SALIDA", () async {
                final idusuario = await obtenerusuarioid();
                final fechahora = await obtenerfechahora();
                final fecha = fechahora['fecha'] ?? '';

                if (idusuario == null || fecha.isEmpty) {
                  mensajeescritorio(context, 'Error', 'No se pudo obtener el ID de usuario o la fecha');
                  return;
                }

                final tieneentrada = await consultarentrada(idusuario: idusuario, fecha: fecha);

                if (!tieneentrada) {
                  msjescritorio(context, 'No hay entrada registrada', 'Primero debes registrar la entrada para poder registrar la salida.');
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => salida(nombreusuario: nombreusuario)),
                  );
                }
              }),
              const SizedBox(height: 20),

              // Botón SALIR DE LA APP
              Estilosbotones.btnlight("SALIR DE LA APP", () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Piedepagina(),
    );
  }
}
