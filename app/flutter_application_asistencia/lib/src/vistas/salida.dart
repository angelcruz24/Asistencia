import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/salida.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class salida extends StatefulWidget {
  final String nombreusuario;

  const salida({super.key, required this.nombreusuario});

  @override
  State<salida> createState() => _SalidaState();
}

class _SalidaState extends State<salida> {
  final salidacontroller controller = salidacontroller();
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
    _solicitarPermisos();
    _cargarDatosDispositivo();
    _cargarDatosUsuario();
    _obtenerfechahoraservidor();
  }

  Future<void> _solicitarPermisos() async {
    await ph.Permission.locationWhenInUse.request();
  }

  Future<void> _cargarDatosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final idusuario = prefs.getInt('usuarioid') ?? 0;
    final nombreusuario = prefs.getString('usuarionombre') ?? '';

    if (mounted) {
      setState(() {
        controller.idusuariocontroller.text = idusuario.toString();
        controller.usuariocontroller.text = nombreusuario;
      });
    }
  }

  Future<void> _cargarDatosDispositivo() async {
    String ip = 'No disponible';
    String bssid = 'No disponible';
    String uuid = 'No disponible';

    try {
      ip = await _networkInfo.getWifiIP() ?? 'No disponible';
      bssid = await _networkInfo.getWifiBSSID() ?? 'No disponible';

      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        uuid = (await deviceInfo.androidInfo).id;
      } else if (Platform.isIOS) {
        uuid = (await deviceInfo.iosInfo).identifierForVendor ?? 'No disponible';
      }
    } catch (e) {
      print('Error obteniendo datos del dispositivo: $e');
    }

    if (mounted) {
      setState(() {
        controller.ipsalidacontroller.text = ip;
        controller.bssidsalidadcontroller.text = bssid;
        controller.uuisalidacontroller.text = uuid;
      });
    }
  }

  Future<void> _obtenerfechahoraservidor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final servidor = prefs.getString('direccion_servidor') ?? 'http://localhost';
      final url = Uri.parse('$servidor/api.php?accion=fechahora');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          if (mounted) {
            setState(() {
              controller.fechasalidacontroller.text = data['fecha']?.toString() ?? '';
              final horaCompleta = data['hora']?.toString() ?? '';
              controller.horasalidacontroller.text = horaCompleta.length >= 5
                  ? horaCompleta.substring(0, 5)
                  : '';
            });
          }
        }
      }
    } catch (e) {
      print('Error al obtener fecha/hora: $e');
    }
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
                  Estilosbotones.btnsuccess("REGISTRAR SALIDA", () {
                    controller.registrarSalida();
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
