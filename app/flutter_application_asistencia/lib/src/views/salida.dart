import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';

class Salida extends StatelessWidget {
  const Salida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    centerTitle: true, // Esto centra el título en Android y iOS
    title: const Text("SALIDA"),
  ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  usuario(),
                  const SizedBox(height: 12),
                  fechasalida(),
                  const SizedBox(height: 12),
                  horasalida(),
                  const SizedBox(height: 12),
                  ipsalida(),
                  const SizedBox(height: 12),
                  macsalida(),
                  const SizedBox(height: 12),
                  actividadesrealizadas(),
                  const SizedBox(height: 24),
                  botonsalida(),
                  const SizedBox(height: 16),
                  botonregresar(),
                ],
              ),
            ),
            const Piedepagina(),
          ],
        ),
      ),
    );
  }

  Widget usuario() {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Usuario',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget fechasalida() {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Fecha de salida',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget horasalida() {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Hora de salida',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget ipsalida() {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'IP de salida',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget macsalida() {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'MAC de salida',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget actividadesrealizadas() {
    return const TextField(
      maxLines: 4,
      decoration: InputDecoration(
        labelText: 'Actividades realizadas',
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget botonsalida() {
    return Estilosbotones.btnsuccess(
      "REGISTRAR SALIDA",
      () {},
    );
  }

  Widget botonregresar() {
    return Estilosbotones.btndanger(
      "REGRESAR",
       () {},
    );
  }
}