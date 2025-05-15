import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';

class entrada extends StatelessWidget {
  final String nombreusuario;

  entrada({super.key, required this.nombreusuario});

  final TextEditingController fechacontroller = TextEditingController();
  final TextEditingController horacontroller = TextEditingController();
  final TextEditingController ipcontroller = TextEditingController();
  final TextEditingController bssidcontroller = TextEditingController();
  final TextEditingController uuicontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuariocontroller = TextEditingController(text: nombreusuario);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENTRADA', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            campoentrada("USUARIO:", usuariocontroller),
            campoentrada("FECHA ENTRADA:", fechacontroller),
            campoentrada("HORA ENTRADA:", horacontroller),
            campoentrada("IP ENTRADA:", ipcontroller),
            campoentrada("BSSID ENTRADA:", bssidcontroller),
            campoentrada("UUI ENTRADA:", uuicontroller),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () {
                    // Acción al registrar entrada
                  }),
                  const SizedBox(height: 15),
                  Estilosbotones.btndanger("REGRESAR", () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => escritorio(nombreusuario: nombreusuario)),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Piedepagina(),
    );
  }

  Widget campoentrada(String etiqueta, TextEditingController controlador) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(etiqueta, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: controlador,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
