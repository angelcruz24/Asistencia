import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_application_asistencia/config.dart';
import 'package:flutter_application_asistencia/src/views/escritorio.dart';
import 'package:http/http.dart' as http;

class LoginController {
  final TextEditingController controllerUsuario = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  void dispose() {
    controllerUsuario.dispose();
    controllerPassword.dispose();
  }

  Future<void> verificarlogin(BuildContext context) async {
    if (controllerUsuario.text.trim().isEmpty ||
        controllerPassword.text.trim().isEmpty) {
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
          'nombre': controllerUsuario.text.trim(),
          'clave': controllerPassword.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Escritorio(nombreUsuario: controllerUsuario.text.trim())),
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
