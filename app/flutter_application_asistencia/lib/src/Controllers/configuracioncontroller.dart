import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfiguracionController {
  final TextEditingController direccionController = TextEditingController();
  String protocolo = 'http';
  final ValueNotifier<String> mensajeConexion = ValueNotifier('');

  bool validarDireccion(String direccion) {
    final ipRegExp = RegExp(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?$');
    final domainRegExp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?$');
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
