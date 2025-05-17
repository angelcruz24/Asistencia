// archivo: entrada.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/entrada.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
import 'package:permission_handler/permission_handler.dart';

class entrada extends StatefulWidget {
  final String nombreusuario;

  const entrada({super.key, required this.nombreusuario});

  @override
  State<entrada> createState() => _EntradaState();
}

class _EntradaState extends State<entrada> {
  late TextEditingController fechacontroller;
  late TextEditingController horacontroller;
  late TextEditingController ipcontroller;
  late TextEditingController bssidcontroller;
  late TextEditingController uuicontroller;
  late TextEditingController idusuariocontroller;
  late TextEditingController nombreusuariocontroller;
  late entradacontroller controller;

  @override
  void initState() {
    super.initState();

    fechacontroller = TextEditingController();
    horacontroller = TextEditingController();
    ipcontroller = TextEditingController();
    bssidcontroller = TextEditingController();
    uuicontroller = TextEditingController();
    idusuariocontroller = TextEditingController();
    nombreusuariocontroller = TextEditingController();

    controller = entradacontroller(
      fechacontroller: fechacontroller,
      horacontroller: horacontroller,
      ipcontroller: ipcontroller,
      bssidcontroller: bssidcontroller,
      uuidcontroller: uuicontroller,
      idusuariocontroller: idusuariocontroller,
      nombreusuariocontroller: nombreusuariocontroller,
    );

    _solicitarPermisos();
    _cargarDatos();
  }

  Future<void> _solicitarPermisos() async {
    await Permission.locationWhenInUse.request();
  }

  Future<void> _cargarDatos() async {
    await controller.cargarDatos();
    if (mounted) setState(() {}); // Refrescar la UI con los nuevos valores
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ENTRADA',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _campoEntrada("ID USUARIO:", idusuariocontroller),
            _campoEntrada("USUARIO:", nombreusuariocontroller),
            _campoEntrada("FECHA ENTRADA:", fechacontroller),
            _campoEntrada("HORA ENTRADA:", horacontroller),
            _campoEntrada("IP ENTRADA:", ipcontroller),
            _campoEntrada("BSSID ENTRADA:", bssidcontroller),
            _campoEntrada("UUID ENTRADA:", uuicontroller),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () {
                    // Lógica para guardar los datos
                  }),
                  const SizedBox(height: 15),
                  Estilosbotones.btndanger("REGRESAR", () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            escritorio(nombreusuario: widget.nombreusuario),
                      ),
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

  Widget _campoEntrada(String etiqueta, TextEditingController controlador) {
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
