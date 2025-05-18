import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/salida.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class salida extends StatefulWidget {
  final String nombreusuario;

  const salida({super.key, required this.nombreusuario});

  @override
  State<salida> createState() => _SalidaState();
}

class _SalidaState extends State<salida> {
  late TextEditingController idusuariocontroller;
  late TextEditingController usuariocontroller;
  late TextEditingController fechasalidacontroller;
  late TextEditingController horasalidacontroller;
  late TextEditingController ipsalidacontroller;
  late TextEditingController bssidsalidadcontroller;
  late TextEditingController uuisalidacontroller;
  late TextEditingController actividadescontroller;
  late salidacontroller controller;

  @override
  void initState() {
    super.initState();

    idusuariocontroller = TextEditingController();
    usuariocontroller = TextEditingController();
    fechasalidacontroller = TextEditingController();
    horasalidacontroller = TextEditingController();
    ipsalidacontroller = TextEditingController();
    bssidsalidadcontroller = TextEditingController();
    uuisalidacontroller = TextEditingController();
    actividadescontroller = TextEditingController();

    controller = salidacontroller(
      idusuariocontroller: idusuariocontroller, 
      usuariocontroller: usuariocontroller, 
      fechasalidacontroller: fechasalidacontroller, 
      horasalidacontroller: horasalidacontroller, 
      ipsalidacontroller: ipsalidacontroller, 
      bssidsalidadcontroller: bssidsalidadcontroller, 
      uuisalidacontroller: uuisalidacontroller, 
      actividadescontroller: actividadescontroller);

    _solicitarPermisos();
    _cargarDatos();
  }

  Future<void> _solicitarPermisos() async {
    await ph.Permission.locationWhenInUse.request();
  }

  Future<void> _cargarDatos() async {
    await controller.cargarDatos();
    if (mounted) setState(() {}); // Refrescar la UI con los nuevos valores
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SALIDA',
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
            _campoEntrada("ID USUARIO:", controller.idusuariocontroller),
            _campoEntrada("USUARIO:", controller.usuariocontroller),
            _campoEntrada("FECHA SALIDA:", controller.fechasalidacontroller),
            _campoEntrada("HORA SALIDA:", controller.horasalidacontroller),
            _campoEntrada("IP SALIDA:", controller.ipsalidacontroller),
            _campoEntrada("BSSID SALIDA:", controller.bssidsalidadcontroller),
            _campoEntrada("UUI SALIDA:", controller.uuisalidacontroller),
            const SizedBox(height: 20),
            _actividadesRealizadas(controller.actividadescontroller),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Estilosbotones.btnsuccess("REGISTRAR SALIDA", () async {
                    bool exito = await controller.registrarsalidaapi();

                    if (exito) {
                      // Mostrar mensaje de éxito
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Salida registrada correctamente')),
                      );
                      // Opcional: navegar o limpiar campos
                    } else {
                      // Mostrar mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al registrar salida')),
                      );
                    }
                  }),
                  const SizedBox(height: 15),
                  Estilosbotones.btndanger("REGRESAR", () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => escritorio(
                              nombreusuario: widget.nombreusuario)),
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
          Text(etiqueta,
              style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _actividadesRealizadas(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("ACTIVIDADES REALIZADAS:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: 4,
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
