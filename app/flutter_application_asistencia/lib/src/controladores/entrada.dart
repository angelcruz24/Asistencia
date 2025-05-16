import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/servicios/funciones.dart';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class entradacontroller {
  final TextEditingController fechacontroller;
  final TextEditingController horacontroller;
  final TextEditingController ipcontroller;
  final TextEditingController bssidcontroller;
  final TextEditingController uuidcontroller;
  final TextEditingController nombreusuariocontroller; 
  final TextEditingController idusuariocontroller;

  entradacontroller({
    required this.fechacontroller,
    required this.horacontroller,
    required this.ipcontroller,
    required this.bssidcontroller,
    required this.uuidcontroller,
    required this.nombreusuariocontroller, 
    required this.idusuariocontroller,
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
    nombreusuariocontroller.text = nombreusuario;
  }

  /// Carga la fecha y hora del servidor usando la dirección guardada en SharedPreferences
  Future<void> _obtenerfechahoraservidor() async {
    final datos = await obtenerfechahora();
    fechacontroller.text = datos['fecha'] ?? 'Error';
    horacontroller.text = datos['hora'] ?? 'Error';
  }

  /// Obtiene datos del dispositivo: IP, BSSID y UUID persistente
  Future<void> _obtenerdatosdispositivo() async {
    final info = NetworkInfo();
    final ip = await info.getWifiIP();
    final bssid = await info.getWifiBSSID();

    final prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString("uuid");

    if (uuid == null) {
      uuid = const Uuid().v4();
      await prefs.setString("uuid", uuid);
    }

    ipcontroller.text = ip ?? "Desconocida";
    bssidcontroller.text = bssid ?? "Desconocido";
    uuidcontroller.text = uuid;
  }
}