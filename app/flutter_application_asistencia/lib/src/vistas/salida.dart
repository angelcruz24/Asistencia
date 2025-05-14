// lib/views/salida_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/salida.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';

class Salida extends StatelessWidget {
  final SalidaController controller = SalidaController();
  final String nombreUsuario;

  Salida({super.key, required this.nombreUsuario});


  @override
  Widget build(BuildContext context) {
    final usuarioController = TextEditingController(text: nombreUsuario);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SALIDA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  campoSoloLectura("Usuario", usuarioController),
                  const SizedBox(height: 12),
                  campoSoloLectura("Fecha de salida", controller.fechaSalidaController),
                  const SizedBox(height: 12),
                  campoSoloLectura("Hora de salida", controller.horaSalidaController),
                  const SizedBox(height: 12),
                  campoSoloLectura("IP de salida", controller.ipSalidaController),
                  const SizedBox(height: 12),
                  campoSoloLectura("MAC de salida", controller.macSalidaController),
                  const SizedBox(height: 12),
                  actividadesrealizadas(controller.actividadesController),
                  const SizedBox(height: 24),
                  Estilosbotones.btnsuccess("REGISTRAR SALIDA", () {
                    controller.registrarSalida();
                  }),
                  const SizedBox(height: 16),
                  Estilosbotones.btndanger("REGRESAR", () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Escritorio(nombreUsuario: nombreUsuario)),
                    );
                  }),
                ],
              ),
            ),
            const Piedepagina(),
          ],
        ),
      ),
    );
  }

  Widget campoSoloLectura(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget actividadesrealizadas(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: const InputDecoration(
        labelText: 'Actividades realizadas',
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}