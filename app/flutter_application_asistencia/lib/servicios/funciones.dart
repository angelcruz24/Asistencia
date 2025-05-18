import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter_application_asistencia/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:wifi_scan/wifi_scan.dart';

/// Obtener fecha y hora desde la API
Future<Map<String, String>> obtenerfechahora() async {
  try {
    if (AppConfig.baseUrl.isEmpty) {
      return {'fecha': 'No URL', 'hora': 'No URL'};
    }

    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=fechahora');
    final response = await http.get(url).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'fecha': data['fecha'] ?? 'Fecha inválida',
        'hora': data['hora'] ?? 'Hora inválida'
      };
    } else {
      return {'fecha': 'Error', 'hora': 'Error'};
    }
  } catch (_) {
    return {'fecha': 'Error', 'hora': 'Error'};
  }
}

/// Obtener el ID del usuario almacenado
Future<int?> obtenerusuarioid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('usuarioid');
}

/// Consultar si ya existe entrada registrada
Future<bool> consultarentrada({required int idusuario, required String fecha}) async {
  try {
    if (AppConfig.baseUrl.isEmpty) return false;
    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=consultarentrada');
    final response = await http.post(
      url,
      body: jsonEncode({'idusuario': idusuario, 'fechaentrada': fecha}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'] == true;
    }
    return false;
  } catch (_) {
    return false;
  }
}

/// Registrar la entrada
Future<bool> registrarentrada({
  required int idusuario,
  required String fechaentrada,
  required String horaentrada,
  required String ip,
  required String bssid,
  required String uuid,
}) async {
  try {
    if (AppConfig.baseUrl.isEmpty) return false;

    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=guardarentrada');
    print('URL: $url');
    print('Enviando datos al servidor...');
    final response = await http.post(
      url,
      body: jsonEncode({
        'usuario': idusuario,
        'fechaentrada': fechaentrada,
        'horaentrada': horaentrada,
        'ipentrada': ip,
        'bssidentrada': bssid,
        'uuidentrada': uuid,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    print('Código de estado: ${response.statusCode}');
    print('Respuesta del servidor: ${response.body}');

    return response.statusCode == 200 &&
           json.decode(response.body)['success'] == true;
  } catch (e) {
    print('Error en registrarentrada: $e');
    return false;
  }
}

/// Registrar la salida
Future<bool> registrarsalida({
  required int idasistencia,
  required String fechasalida,
  required String horasalida,
  required String ipsalida,
  required String bssidsalida,
  required String uuidsalida,
  required String actividades,
}) async {
  try {
    if (AppConfig.baseUrl.isEmpty) return false;

    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=guardarsalida');
    print('URL: $url');
    print('Enviando datos al servidor...');
    final response = await http.post(
      url,
      body: jsonEncode({
        'id': idasistencia,
        'fechasalida': fechasalida,
        'horasalida': horasalida,
        'ipsalida': ipsalida,
        'bssidsalida': bssidsalida,
        'uuidsalida': uuidsalida,
        'actividades': actividades,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    print('Código de estado: ${response.statusCode}');
    print('Respuesta del servidor: ${response.body}');

    return response.statusCode == 200 &&
           json.decode(response.body)['success'] == true;
  } catch (e) {
    print('Error en registrarsalida: $e');
    return false;
  }
}

///////////////////////////////
/// FUNCIONES DE DISPOSITIVO ///
///////////////////////////////

Future<String> obtenerip() async {
  try {
    final info = NetworkInfo();
    final ip = await info.getWifiIP();
    return ip ?? 'No disponible';
  } catch (e) {
    print('Error al obtener IP: $e');
    return 'Error';
  }
}

Future<String> obtenerbssid() async {
  try {
    final canScan = await WiFiScan.instance.canStartScan();
    if (canScan == CanStartScan.yes) {
      await WiFiScan.instance.startScan();
      await Future.delayed(const Duration(seconds: 2));
      final bssid = await NetworkInfo().getWifiBSSID();
      return bssid ?? 'No disponible';
    } else {
      return 'Permiso denegado';
    }
  } catch (e) {
    print('Error al obtener BSSID: $e');
    return 'Error';
  }
}

Future<String> obteneruuid() async {
  try {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'No disponible';
    }
    return 'Plataforma desconocida';
  } catch (e) {
    print('Error al obtener UUID: $e');
    return 'Error';
  }
}
