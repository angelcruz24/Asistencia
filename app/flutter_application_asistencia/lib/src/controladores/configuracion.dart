import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class configuracioncontroller {
  final TextEditingController direccioncontroller = TextEditingController();
  String protocolo = 'http';
  final ValueNotifier<List<String>> mensajesConexion = ValueNotifier([]);

  configuracioncontroller() {
    _cargardireccionguardada();
  }

  void _agregarMensaje(String mensaje) {
    mensajesConexion.value = [...mensajesConexion.value, mensaje];
    print(mensaje);
  }

  void _cargardireccionguardada() async {
    final prefs = await SharedPreferences.getInstance();
    final url = prefs.getString('base_url') ?? '';
    if (url.startsWith('https://')) {
      protocolo = 'https';
      direccioncontroller.text = url.replaceFirst('https://', '');
    } else if (url.startsWith('http://')) {
      protocolo = 'http';
      direccioncontroller.text = url.replaceFirst('http://', '');
    }
  }

  Future<void> guardardireccion({bool conexionexitosa = false}) async {
    final prefs = await SharedPreferences.getInstance();
    String direccion = direccioncontroller.text.trim();
    if (!direccion.endsWith('/')) {
      direccion += '/';
    }
    final url = '$protocolo://$direccion/asistencia/api/';
    await prefs.setString('base_url', url);
    await prefs.setBool('conexion_exitosa', conexionexitosa);
    _agregarMensaje('💾 Dirección guardada correctamente.');
    _agregarMensaje('📦 Estado de conexión guardado: $conexionexitosa');
  }

  bool validardireccion(String direccion) {
    final ipregexp = RegExp(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?$');
    final domainregexp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?$');
    return ipregexp.hasMatch(direccion) || domainregexp.hasMatch(direccion);
  }

  Future<void> probarconexion() async {
    mensajesConexion.value = []; // Limpiar mensajes anteriores
    final direccion = direccioncontroller.text.trim();

    if (!validardireccion(direccion)) {
      _agregarMensaje('❌ Dirección inválida.');
      return;
    }

    _agregarMensaje('✅ Dirección válida: $direccion');
    _agregarMensaje('🔧 Preparando conexión...');

    final urlcompleta =
        '$protocolo://$direccion/asistencia/api/usuariosapp.php?accion=ping';
    _agregarMensaje('🔌 Estableciendo conexión con el servidor...');

    try {
      final uri = Uri.parse(urlcompleta);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ).timeout(const Duration(seconds: 5));

      _agregarMensaje('📡 Respuesta recibida (código ${response.statusCode})');

      if (response.statusCode == 200) {
        await guardardireccion(conexionexitosa: true);
        _agregarMensaje('✅ Conexión exitosa. Dirección guardada.');
      } else {
        _agregarMensaje('⚠ Error HTTP: Código ${response.statusCode}');
      }
    } on TimeoutException {
      _agregarMensaje('⏱ Tiempo de espera agotado: el servidor no respondió.');
    } on http.ClientException catch (e) {
      _agregarMensaje('❌ Error de cliente HTTP: ${e.message}');
    } catch (e) {
      _agregarMensaje('❌ Error desconocido: ${e.toString()}');
    }
  }

  void dispose() {
    direccioncontroller.dispose();
    mensajesConexion.dispose();
  }
}
