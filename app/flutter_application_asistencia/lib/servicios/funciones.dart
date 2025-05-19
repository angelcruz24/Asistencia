import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
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

/// Registrar la entrada y obtener el ID generado
Future<int?> registrarentrada({
  required int idusuario,
  required String fechaentrada,
  required String horaentrada,
  required String ip,
  required String bssid,
  required String uuid,
}) async {
  try {
    if (AppConfig.baseUrl.isEmpty) return null;

    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=guardarentrada');
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

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return data['id'];
      }
    }
    return null;
  } catch (e) {
    print('Error en registrarentrada: $e');
    return null;
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


//MENSAJE DE ENTRADA\\
void mostrarmensaje({
  required BuildContext context,
  required String titulo,
  required String mensaje,
  DialogType tipo = DialogType.info,
}) {
  AwesomeDialog(
    context: context,
    dialogType: tipo,
    animType: AnimType.bottomSlide,
    title: titulo,
    desc: mensaje,
    btnOkText: "Aceptar",
    btnOkColor: const Color.fromRGBO(31, 206, 7, 0.658),
    btnOkOnPress: () {},
    dismissOnTouchOutside: false,
  ).show();
}

Future<Object?> registrar(BuildContext context, dynamic fechacontroller, dynamic horacontroller, dynamic ipcontroller, dynamic bssidcontroller, dynamic uuidcontroller) async {
  final idusuario = await obtenerusuarioid();
  if (idusuario == null) {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se pudo obtener el ID del usuario.",
      tipo: DialogType.error,
    );
    return false;
  }

  final exito = await registrarentrada(
    idusuario: idusuario,
    fechaentrada: fechacontroller.text,
    horaentrada: horacontroller.text,
    ip: ipcontroller.text,
    bssid: bssidcontroller.text,
    uuid: uuidcontroller.text,
  );

  if (exito != null) {
    mostrarmensaje(
      context: context,
      titulo: "Éxito",
      mensaje: "Entrada registrada correctamente.",
      tipo: DialogType.success,
    );
  } else {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se pudo registrar la entrada.",
      tipo: DialogType.error,
    );
  }

  return exito;
}

//MENSAJE DE SALIDA\\
Future<Object?> registrarsalidas(
    BuildContext context,
    dynamic fechasalidacontroller,
    dynamic horasalidacontroller,
    dynamic ipsalidacontroller,
    dynamic bssidsalidadcontroller,
    dynamic uuisalidacontroller,
    TextEditingController actividadescontroller) async {

  final prefs = await SharedPreferences.getInstance();
  final idasistencia = prefs.getInt('idasistencia');

  if (idasistencia == null) {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se encontró el ID de asistencia en SharedPreferences.",
      tipo: DialogType.error,
    );
    return false;
  }

  final fecha = fechasalidacontroller.text;
  final hora = horasalidacontroller.text;
  final ip = ipsalidacontroller.text;
  final bssid = bssidsalidadcontroller.text;
  final uuid = uuisalidacontroller.text;
  final actividades = actividadescontroller.text;

  if (fecha.isEmpty || hora.isEmpty) {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "Datos de fecha u hora inválidos.",
      tipo: DialogType.error,
    );
    return false;
  }

  final exito = await registrarsalida(
    idasistencia: idasistencia,
    fechasalida: fecha,
    horasalida: hora,
    ipsalida: ip,
    bssidsalida: bssid,
    uuidsalida: uuid,
    actividades: actividades,
  );

  if (exito) {
    await prefs.remove('idasistencia');
    mostrarmensaje(
      context: context,
      titulo: "Éxito",
      mensaje: "Salida registrada correctamente.",
      tipo: DialogType.success,
    );
  } else {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se pudo registrar la salida.",
      tipo: DialogType.error,
    );
  }

  return exito;
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
