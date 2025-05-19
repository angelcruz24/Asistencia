import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/servicios/funciones.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print("Datos desde el servidor: $datos");

    if (datos['fecha'] != 'Error' && datos['hora'] != 'Error') {
      fechacontroller.text = datos['fecha'] ?? 'SIN FECHA';
      horacontroller.text = datos['hora'] ?? 'SIN HORA';
    } else {
      fechacontroller.text = 'ERROR';
      horacontroller.text = 'ERROR';
    }
  }

  /// Obtiene datos del dispositivo: IP, BSSID y UUID persistente
  Future<void> _obtenerdatosdispositivo() async {
  final ip = await obtenerip();       // ← desde funciones.dart
  final bssid = await obtenerbssid(); // ← desde funciones.dart
  final uuid = await obteneruuid();   // ← desde funciones.dart

  ipcontroller.text = ip;
  bssidcontroller.text = bssid;
  uuidcontroller.text = uuid;
  }

  Future<int?> registrar() async {
    final idusuario = await obtenerusuarioid(); 
    if (idusuario == null) return null;

    final idasistencia = await registrarentrada(
      idusuario: idusuario,
      fechaentrada: fechacontroller.text,
      horaentrada: horacontroller.text,
      ip: ipcontroller.text,
      bssid: bssidcontroller.text,
      uuid: uuidcontroller.text,
    );

    return idasistencia; // Devuelve el ID generado si todo fue bien
  }

}
