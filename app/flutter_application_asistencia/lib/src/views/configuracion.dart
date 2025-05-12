import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/views/iniciodesesion.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({super.key});

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
                  botonregresar(context)
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dirección del Servidor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Ej. http://192.168.1.1:8000',
          ),
        ),
      ],
    );
  }

  Widget botonconexion() {
    return Estilosbotones.btnprimary(
      "probar conxion",
      () {},
    );
  }

 Widget resultadoconexion() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Resultado de la Conexión',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      Container(
        height: 100, // Aumenta la altura del campo
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Align(
          alignment: Alignment.topLeft,
          child: Text('Aqui se mostrara el resltado de conexion'), // Espacio para el resultado
        ),
      ),
    ],
  );
}

  Widget botonregresar(BuildContext context) {
  return Estilosbotones.btndanger(
    "Regresar",
    () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login(title: 'Login')),
      );
    },
  );
}
}
