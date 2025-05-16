import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_application_asistencia/config.dart';
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class logincontroller {
  final TextEditingController controllerusuario = TextEditingController();
  final TextEditingController controllerpassword = TextEditingController();

  void dispose() {
    controllerusuario.dispose();
    controllerpassword.dispose();
  }

  Future<void> verificarlogin(BuildContext context) async {
    if (AppConfig.baseUrl.trim().isEmpty) {
      mostrarmensaje(
        context,
        'Sin conexión',
        'Primero debes establecer una conexión al servidor desde la configuración.',
        DialogType.warning,
      );
      return;
    }
    if (controllerusuario.text.trim().isEmpty ||
        controllerpassword.text.trim().isEmpty) {
      mostrarmensaje(
          context, 'ERROR', 'Por favor, ingresa usuario y contraseña', DialogType.error);
      return;
    }

    final url = Uri.parse(
        "${AppConfig.baseUrl}usuariosapp.php?accion=login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'nombre': controllerusuario.text.trim(),
          'clave': controllerpassword.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          // Conversión segura del ID
          int idusuario = int.tryParse(data['id'].toString()) ?? 0;
          String nombreusuario = data['nombre']?.toString() ?? controllerusuario.text.trim();

          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('usuarioid', idusuario);
          await prefs.setString('usuarionombre', nombreusuario);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => escritorio(nombreusuario: nombreusuario)),
          );
        } else {
          mostrarmensaje(context, 'Login', data['message'], DialogType.error);
        }
      } else {
        mostrarmensaje(context, 'Error',
            'Error en la solicitud: ${response.statusCode}', DialogType.error);
      }
    } catch (e) {
      mostrarmensaje(context, 'Error', 'Error al conectarse al servidor: $e',
          DialogType.error);
    }
  }

  void mostrarmensaje(
      BuildContext context, String titulo, String mensaje, DialogType tipo) {
    AwesomeDialog(
      context: context,
      dialogType: tipo,
      animType: AnimType.bottomSlide,
      title: titulo,
      desc: mensaje,
      btnOkOnPress: () {},
    ).show();
  }
}
