import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/configuracion.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/login.dart';

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  final ConfiguracionController controlador = ConfiguracionController();

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURACION'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  direccionservidor(),
                  const SizedBox(height: 20),
                  botonconexion(),
                  const SizedBox(height: 20),
                  resultadoconexion(),
                  const SizedBox(height: 20),
                  botonregresar(context),
                ],
              ),
            ),
          ),
          const Piedepagina(),
        ],
      ),
    );
  }

  Widget direccionservidor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dirección del Servidor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controlador.direccionController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ej. 192.168.1.1:8000 o ejemplo.com',
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: controlador.protocolo,
          decoration: const InputDecoration(labelText: 'Protocolo'),
          items: const [
            DropdownMenuItem(value: 'http', child: Text('http://')),
            DropdownMenuItem(value: 'https', child: Text('https://')),
          ],
          onChanged: (value) {
            setState(() {
              controlador.protocolo = value!;
            });
          },
        ),
      ],
    );
  }

  Widget botonconexion() {
    return Estilosbotones.btnprimary(
      "PROBAR CONEXION",
      () async {
        await controlador.probarconexion();
        setState(() {}); // Refresca el resultado
      },
    );
  }

  Widget resultadoconexion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'RESULTADO DE LA CONEXION',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              controlador.mensajeConexion.value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget botonregresar(BuildContext context) {
    return Estilosbotones.btndanger(
      "REGRESAR",
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
    );
  }
}
