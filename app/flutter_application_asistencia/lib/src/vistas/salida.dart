// lib/views/salida_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/salida.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';

class salida extends StatelessWidget {
  final salidacontroller controller = salidacontroller();
  final String nombreusuario;

  salida({super.key, required this.nombreusuario});


  @override
  Widget build(BuildContext context) {
    final usuariocontroller = TextEditingController(text: nombreusuario);
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
                  campoSoloLectura("Usuario", usuariocontroller),
                  const SizedBox(height: 12),
                  campoSoloLectura("Fecha de salida", controller.fechasalidacontroller),
                  const SizedBox(height: 12),
                  campoSoloLectura("Hora de salida", controller.horasalidacontroller),
                  const SizedBox(height: 12),
                  campoSoloLectura("IP de salida", controller.ipsalidacontroller),
                  const SizedBox(height: 12),
                  campoSoloLectura("BSSID de salida", controller.bssidsalidadcontroller),
                  const SizedBox(height: 12),
                  campoSoloLectura("UUI de salida", controller.uuisalidacontroller),
                  const SizedBox(height: 12),
                  actividadesrealizadas(controller.actividadescontroller),
                  const SizedBox(height: 24),
                  Estilosbotones.btnsuccess("REGISTRAR SALIDA", () {
                    controller.registrarSalida();
                  }),
                  const SizedBox(height: 16),
                  Estilosbotones.btndanger("REGRESAR", () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => escritorio(nombreusuario: nombreusuario)),
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
