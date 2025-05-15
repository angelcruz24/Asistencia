import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';


class entrada extends StatelessWidget {
  final String nombreusuario;

  entrada({super.key, required this.nombreusuario});

  //final TextEditingController usuarioController = TextEditingController(text: "Juan Pérez");
  final TextEditingController fechacontroller = TextEditingController(text: "2025-05-12");
  final TextEditingController horacontroller = TextEditingController(text: "08:30 AM");
  final TextEditingController ipcontroller = TextEditingController(text: "192.168.1.15");
  final TextEditingController bssidcontroller = TextEditingController(text: "00:1A:2B:3C:4D:5E");
  final TextEditingController uuicontroller = TextEditingController(text: "00:1A:2B:3C:4D:5E");

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
                    // Aquí puedes poner un mensaje o lógica de guardado
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
            readOnly: true, // Campo solo lectura
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
