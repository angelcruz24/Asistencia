import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/views/escritorio.dart';


class Entrada extends StatelessWidget {
  final TextEditingController usuarioController = TextEditingController(text: "Juan Pérez");
  final TextEditingController fechaController = TextEditingController(text: "2025-05-12");
  final TextEditingController horaController = TextEditingController(text: "08:30 AM");
  final TextEditingController ipController = TextEditingController(text: "192.168.1.15");
  final TextEditingController macController = TextEditingController(text: "00:1A:2B:3C:4D:5E");

  @override
  Widget build(BuildContext context) {
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
            campoentrada("USUARIO:", usuarioController),
            campoentrada("FECHA ENTRADA:", fechaController),
            campoentrada("HORA ENTRADA:", horaController),
            campoentrada("IP ENTRADA:", ipController),
            campoentrada("MAC ENTRADA:", macController),
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
                      MaterialPageRoute(builder: (context) => const Escritorio()),
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
