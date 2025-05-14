import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class configuracioncontroller {
  final TextEditingController direccioncontroller = TextEditingController();
  String protocolo = 'http';
  final ValueNotifier<String> mensajeconexion = ValueNotifier('');

  configuracioncontroller() {
    _cargardireccionguardada();
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
    print('✅ Dirección guardada: $url');
    print('📦 Estado de conexión guardado: $conexionexitosa');
  }

  bool validardireccion(String direccion) {
    final ipregexp = RegExp(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?$');
    final domainregexp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?$');
    return ipregexp.hasMatch(direccion) || domainregexp.hasMatch(direccion);
  }

  Future<void> probarconexion() async {
    final direccion = direccioncontroller.text.trim();

    if (!validardireccion(direccion)) {
      mensajeconexion.value = '❌ Dirección inválida';
      print('❌ Dirección inválida: $direccion');
      return;
    }

    mensajeconexion.value = '⏳ Conectando...';
    final urlcompleta =
        '$protocolo://$direccion/asistencia/api/usuariosapp.php?accion=ping';
    print('🌐 Intentando conectar a: $urlcompleta');

    try {
      final uri = Uri.parse(urlcompleta);

      // Hacer la solicitud POST en lugar de GET
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ).timeout(const Duration(seconds: 5));

      // Verificar la respuesta
      if (response.statusCode == 200) {
        await guardardireccion(
            conexionexitosa:
                true); // Guardar la dirección y el estado de la conexión exitosa
        mensajeconexion.value = '✅ Conexión exitosa (POST con accion=ping)';
        print('✅ Conexión exitosa con POST a $urlcompleta');
      } else {
        mensajeconexion.value = '⚠ Error HTTP: Código ${response.statusCode}';
        print('⚠ Error HTTP: Código ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      mensajeconexion.value =
          '⏱ Tiempo de espera agotado: el servidor no respondió.';
      print('⏱ TimeoutException: $e');
    } on http.ClientException catch (e) {
      mensajeconexion.value = '❌ Error HTTP: Verifica la dirección o conexión.';
      print('❌ ClientException: $e');
    } catch (e) {
      mensajeconexion.value = '❌ No se pudo conectar: ${e.toString()}';
      print('❌ Excepción desconocida: $e');
    }
  }

  void dispose() {
    direccioncontroller.dispose();
    mensajeconexion.dispose();
  }
}
