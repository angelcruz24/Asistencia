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
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No se pudo obtener el ID de usuario o la fecha'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                      ],
                    ),
                  );
                  return;
                }

                final yatieneentrada = await consultarentrada(idusuario: idusuario, fecha: fecha);

                if (yatieneentrada) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Entrada ya registrada'),
                      content: const Text('Ya has registrado tu entrada hoy.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Aceptar')),
                      ],
                    ),
                  );
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
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('No se pudo obtener el ID de usuario o la fecha'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                      ],
                    ),
                  );
                  return;
                }

                final tieneentrada = await consultarentrada(idusuario: idusuario, fecha: fecha);

                if (!tieneentrada) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('No hay entrada registrada'),
                      content: const Text('Primero debes registrar la entrada para poder registrar la salida.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Aceptar')),
                      ],
                    ),
                  );
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

