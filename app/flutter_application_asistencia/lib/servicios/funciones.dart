import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> obtenerfechahora() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('base_url');
    if (baseUrl == null || baseUrl.isEmpty) {
      return {'fecha': 'No URL', 'hora': 'No URL'};
    }

    final url = Uri.parse('$baseUrl?accion=fechahora');
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

Future<int?> obtenerusuarioid() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('usuario_id');
}

Future<bool> consultarentrada({required int idusuario, required String fecha}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('base_url');
    if (baseUrl == null || baseUrl.isEmpty) return false;

    final url = Uri.parse('$baseUrl?accion=consultarentrada');
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

Future<bool> registrarentrada({
  required int idusuario,
  required String ip,
  required String bssid,
  required String uuid,
}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('base_url');
    if (baseUrl == null || baseUrl.isEmpty) return false;

    final url = Uri.parse('$baseUrl?accion=guardarentrada');
    final response = await http.post(
      url,
      body: jsonEncode({
        'usuario': idusuario,
        'ipentrada': ip,
        'bssidentrada': bssid,
        'uuidentrada': uuid,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    return response.statusCode == 200 &&
           json.decode(response.body)['success'] == true;
  } catch (_) {
    return false;
  }
}

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
    final prefs = await SharedPreferences.getInstance();
    final baseUrl = prefs.getString('base_url');
    if (baseUrl == null || baseUrl.isEmpty) return false;

    final url = Uri.parse('$baseUrl?accion=guardarsalida');
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

    return response.statusCode == 200 &&
           json.decode(response.body)['success'] == true;
  } catch (_) {
    return false;
  }
}
