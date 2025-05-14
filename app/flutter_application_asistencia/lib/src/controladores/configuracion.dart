import 'dart:async';
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

  Future<void> guardarDireccion({bool conexionExitosa = false}) async {
    final prefs = await SharedPreferences.getInstance();
    String direccion = direccionController.text.trim();
    if (!direccion.endsWith('/')) {
      direccion += '/';
    }
    final url = '$protocolo://$direccion/asistencia/api/';
    await prefs.setString('base_url', url);
    await prefs.setBool('conexion_exitosa', conexionExitosa);
    print('✅ Dirección guardada: $url');
    print('📦 Estado de conexión guardado: $conexionExitosa');
  }

  bool validarDireccion(String direccion) {
    final ipRegExp = RegExp(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?$');
    final domainRegExp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?$');
    return ipRegExp.hasMatch(direccion) || domainRegExp.hasMatch(direccion);
  }

  Future<void> probarConexion() async {
    final direccion = direccionController.text.trim();

    if (!validarDireccion(direccion)) {
      mensajeConexion.value = '❌ Dirección inválida';
      print('❌ Dirección inválida: $direccion');
      return;
    }

    mensajeConexion.value = '⏳ Conectando...';
    final urlCompleta =
        '$protocolo://$direccion/asistencia/api/usuariosapp.php?accion=ping';
    print('🌐 Intentando conectar a: $urlCompleta');

    try {
      final uri = Uri.parse(urlCompleta);

      // Hacer la solicitud POST en lugar de GET
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ).timeout(const Duration(seconds: 5));

      // Verificar la respuesta
      if (response.statusCode == 200) {
        await guardarDireccion(
            conexionExitosa:
                true); // Guardar la dirección y el estado de la conexión exitosa
        mensajeConexion.value = '✅ Conexión exitosa (POST con accion=ping)';
        print('✅ Conexión exitosa con POST a $urlCompleta');
      } else {
        mensajeConexion.value = '⚠ Error HTTP: Código ${response.statusCode}';
        print('⚠ Error HTTP: Código ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      mensajeConexion.value =
          '⏱ Tiempo de espera agotado: el servidor no respondió.';
      print('⏱ TimeoutException: $e');
    } on http.ClientException catch (e) {
      mensajeConexion.value = '❌ Error HTTP: Verifica la dirección o conexión.';
      print('❌ ClientException: $e');
    } catch (e) {
      mensajeConexion.value = '❌ No se pudo conectar: ${e.toString()}';
      print('❌ Excepción desconocida: $e');
    }
  }

  void dispose() {
    direccionController.dispose();
    mensajeConexion.dispose();
  }
}
