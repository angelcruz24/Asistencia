import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/config.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
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
  final NetworkInfo _networkInfo = NetworkInfo();

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
    
    _solicitarPermisos();
    _cargardatosdispositivo();
    _obtenerfechahoraservidor();
    _cargardatosusuario();
  }

  Future<void> _solicitarPermisos() async {
    await Permission.locationWhenInUse.request();
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
      print('Error en datos del dispositivo: $e');
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
      final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=fechahora');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            fechacontroller.text = data['fecha'];
            horacontroller.text = data['hora'];
          });
        } else {
          print('Error desde el servidor: ${data['message']}');
        }
      } else {
        print('Error de red: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener fecha y hora del servidor: $e');
    }
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
}
