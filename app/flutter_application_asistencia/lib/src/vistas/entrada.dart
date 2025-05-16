import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_scan/wifi_scan.dart';  
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;

class entrada extends StatefulWidget {
  final String nombreusuario;

  const entrada({super.key, required this.nombreusuario});

  @override
  State<entrada> createState() => _entradaState();
}

class _entradaState extends State<entrada> {
  late TextEditingController fechacontroller;
  late TextEditingController horacontroller;
  late TextEditingController ipcontroller;
  late TextEditingController bssidcontroller;
  late TextEditingController uuicontroller;
  late TextEditingController idusuariocontroller;
  late TextEditingController nombreusuariocontroller;

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
    
    _cargardatosdispositivo();
    _obtenerfechahoraservidor();
    _cargardatosusuario();
  }

  Future<void> _cargardatosusuario() async {
    final prefs = await SharedPreferences.getInstance();
    final idusuario = prefs.getInt('usuarioid') ?? 0;
    final nombreusuario = prefs.getString('usuarionombre') ?? '';

    if (mounted) {
      setState(() {
        idusuariocontroller.text = idusuario.toString();
        nombreusuariocontroller.text = nombreusuario;
      });
    }
  }
  
  Future<void> _cargardatosdispositivo() async {
  // Obtener IP
  final ip = await NetworkInfo().getWifiIP() ?? 'No disponible';
  
  // Obtener BSSID (Nueva implementación con wifi_scan)
  String bssid = 'No disponible';
  try {
    final can = await WiFiScan.instance.canStartScan();
    if (can == CanStartScan.yes) {
      final result = await WiFiScan.instance.getScannedResults();
      if (result.isNotEmpty) bssid = result.first.bssid;
    }
  } catch (e) {
    print('Error BSSID: $e');
  }

  // Obtener UUID (Implementación corregida)
  String uuid = 'No disponible';
  try {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      uuid = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      uuid = iosInfo.identifierForVendor ?? 'No disponible';
    }
  } catch (e) {
    print('Error UUID: $e');
  }

  if (mounted) {
    setState(() {
      ipcontroller.text = ip;
      bssidcontroller.text = bssid;
      uuicontroller.text = uuid;
    });
  }
}

  Future<void> _obtenerfechahoraservidor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final servidor = prefs.getString('direccion_servidor') ?? 'http://localhost';
      final url = Uri.parse('$servidor/api.php?accion=fechahora'); // ← Asegúrate que el path coincida

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          if (mounted) {
            setState(() {
              fechacontroller.text = data['fecha'] ?? '';
              horacontroller.text = data['hora']?.substring(0, 5) ?? ''; // hh:mm
            });
          }
        } else {
          print('Error del servidor: ${data['message']}');
        }
      } else {
        print('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }


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
            _campoEntrada("ID USUARIO:", idusuariocontroller),
            _campoEntrada("USUARIO:", nombreusuariocontroller),
            _campoEntrada("FECHA ENTRADA:", fechacontroller),
            _campoEntrada("HORA ENTRADA:", horacontroller),
            _campoEntrada("IP ENTRADA:", ipcontroller),
            _campoEntrada("BSSID ENTRADA:", bssidcontroller),
            _campoEntrada("UUI ENTRADA:", uuicontroller),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () {}),
                  const SizedBox(height: 15),
                  Estilosbotones.btndanger("REGRESAR", () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => escritorio(nombreusuario: widget.nombreusuario)),
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
