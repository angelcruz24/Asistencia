import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ConfiguracionController {
  final TextEditingController direccionController = TextEditingController();
  String protocolo = 'http';
  final ValueNotifier<String> mensajeConexion = ValueNotifier('');

  ConfiguracionController() {
    _cargarDireccionGuardada();
  }

  void _cargarDireccionGuardada() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('base_url') ?? '';
    if (url.startsWith('https://')) {
      protocolo = 'https';
      direccionController.text = url.replaceFirst('https://', '');
    } else if (url.startsWith('http://')) {
      protocolo = 'http';
      direccionController.text = url.replaceFirst('http://', '');
    }
  }

  Future<void> guardarDireccion() async {
    final prefs = await SharedPreferences.getInstance();
    String direccion = direccionController.text.trim();
    if (!direccion.endsWith('/')) {
      direccion += '/';
    }
    final url = '$protocolo://$direccion';
    await prefs.setString('base_url', url);
  }

  bool validarDireccion(String direccion) {
    final ipRegExp = RegExp(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?\$');
    final domainRegExp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?\$');
    return ipRegExp.hasMatch(direccion) || domainRegExp.hasMatch(direccion);
  }

  Future<void> probarConexion() async {
    final direccion = direccionController.text.trim();

    if (!validarDireccion(direccion)) {
      mensajeConexion.value = '❌ Dirección inválida';
      return;
    }

    mensajeConexion.value = 'Conectando...';

    try {
      final uri = Uri.parse('$protocolo://$direccion');
      final response = await http.get(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        mensajeConexion.value = '✅ Conexión exitosa';
        await guardarDireccion();
      } else {
        mensajeConexion.value = '⚠ Error: código ${response.statusCode}';
      }
    } catch (e) {
      mensajeConexion.value = '❌ No se pudo conectar: $e';
    }
  }

  void dispose() {
    direccionController.dispose();
    mensajeConexion.dispose();
  }
}
