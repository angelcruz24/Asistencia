// lib/controllers/salida_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/servicios/funciones.dart';
import 'package:shared_preferences/shared_preferences.dart';

class salidacontroller {
  final TextEditingController idusuariocontroller;
  final TextEditingController usuariocontroller;
  final TextEditingController fechasalidacontroller;
  final TextEditingController horasalidacontroller;
  final TextEditingController ipsalidacontroller;
  final TextEditingController bssidsalidadcontroller;
  final TextEditingController uuisalidacontroller;
  final TextEditingController actividadescontroller;

  salidacontroller({
    required this.idusuariocontroller,
    required this.usuariocontroller,
    required this.fechasalidacontroller,
    required this.horasalidacontroller,
    required this.ipsalidacontroller,
    required this.bssidsalidadcontroller, 
    required this.uuisalidacontroller,
    required this.actividadescontroller,
  });

  /// Método principal para cargar todos los datos en la vista
  Future<void> cargarDatos() async {
    await _cargardatosusuario();
    await _obtenerfechahoraservidor();
    await _obtenerdatosdispositivo();
  }

  Future<void> _cargardatosusuario() async {
    final prefs = await SharedPreferences.getInstance();
    final idusuario = prefs.getInt('usuarioid') ?? 0;
    final nombreusuario = prefs.getString('usuarionombre') ?? '';


    idusuariocontroller.text = idusuario.toString();
    usuariocontroller.text = nombreusuario;
  }

  /// Carga la fecha y hora del servidor usando la dirección guardada en SharedPreferences
  Future<void> _obtenerfechahoraservidor() async {
    final datos = await obtenerfechahora();
    print("Datos desde el servidor: $datos");

    if (datos['fecha'] != 'Error' && datos['hora'] != 'Error') {
      fechasalidacontroller.text = datos['fecha'] ?? 'SIN FECHA';
      horasalidacontroller.text = datos['hora'] ?? 'SIN HORA';
    } else {
      fechasalidacontroller.text = 'ERROR';
      horasalidacontroller.text = 'ERROR';
    }
  }

  /// Obtiene datos del dispositivo: IP, BSSID y UUID persistente
  Future<void> _obtenerdatosdispositivo() async {
  final ip = await obtenerip();       // ← desde funciones.dart
  final bssid = await obtenerbssid(); // ← desde funciones.dart
  final uuid = await obteneruuid();   // ← desde funciones.dart

  ipsalidacontroller.text = ip;
  bssidsalidadcontroller.text = bssid;
  uuisalidacontroller.text = uuid;
  }

  Future<bool> registrarsalidaapi() async {
    final id = int.tryParse(idusuariocontroller.text) ?? 0;
    final fecha = fechasalidacontroller.text;
    final hora = horasalidacontroller.text;
    final ip = ipsalidacontroller.text;
    final bssid = bssidsalidadcontroller.text;
    final uuid = uuisalidacontroller.text;
    final actividades = actividadescontroller.text;

    if (id == 0 || fecha.isEmpty || hora.isEmpty) {
      return false; // datos inválidos
    }

    // Llamas a la función real que hace el POST
    final exito = await registrarsalida(
      idasistencia: id,
      fechasalida: fecha,
      horasalida: hora,
      ipsalida: ip,
      bssidsalida: bssid,
      uuidsalida: uuid,
      actividades: actividades,
    );

    return exito;
  }

  void dispose() {
    idusuariocontroller.dispose();
    usuariocontroller.dispose();
    fechasalidacontroller.dispose();
    horasalidacontroller.dispose();
    ipsalidacontroller.dispose();
    bssidsalidadcontroller.dispose();
    uuisalidacontroller.dispose();
    actividadescontroller.dispose();
  }
}

  
