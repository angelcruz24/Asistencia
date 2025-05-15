import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class EntradaController {
  final TextEditingController fechaController;
  final TextEditingController horaController;
  final TextEditingController ipController;
  final TextEditingController bssidController;
  final TextEditingController uuidController;

  EntradaController({
    required this.fechaController,
    required this.horaController,
    required this.ipController,
    required this.bssidController,
    required this.uuidController,
  });

  /// Método principal para cargar todos los datos en la vista
  Future<void> cargarDatos() async {
    await _obtenerFechaHoraServidor();
    await _obtenerDatosDispositivo();
  }

  /// Carga la fecha y hora del servidor usando la dirección guardada en SharedPreferences
  Future<void> _obtenerFechaHoraServidor() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final baseUrl = prefs.getString('base_url');

      if (baseUrl == null || baseUrl.isEmpty) {
        fechaController.text = "No URL";
        horaController.text = "No URL";
        return;
      }

      final url = Uri.parse('${baseUrl}fecha_hora.php');
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fechaController.text = data['fecha'] ?? 'Fecha inválida';
        horaController.text = data['hora'] ?? 'Hora inválida';
      } else {
        fechaController.text = "Error ${response.statusCode}";
        horaController.text = "Error ${response.statusCode}";
      }
    } on TimeoutException {
      fechaController.text = "Tiempo agotado";
      horaController.text = "Tiempo agotado";
    } catch (e) {
      fechaController.text = "Error";
      horaController.text = "Error";
    }
  }

  /// Obtiene datos del dispositivo: IP, BSSID y UUID persistente
  Future<void> _obtenerDatosDispositivo() async {
    final info = NetworkInfo();
    final ip = await info.getWifiIP();
    final bssid = await info.getWifiBSSID();

    final prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString("uuid");

    if (uuid == null) {
      uuid = const Uuid().v4();
      await prefs.setString("uuid", uuid);
    }

    ipController.text = ip ?? "Desconocida";
    bssidController.text = bssid ?? "Desconocido";
    uuidController.text = uuid;
  }
}