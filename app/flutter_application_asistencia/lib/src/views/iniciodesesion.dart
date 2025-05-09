import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => Iniciosesion();
}

class Iniciosesion extends State<Login> {
  final TextEditingController controllerUsuario = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    controllerUsuario.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.asset(
            'assets/logos/fa-solid fa-gear.png',
            height: 28,
            width: 28,
          ),
        ),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo(),
                  const SizedBox(height: 32),
                  txtUsuario(),
                  const SizedBox(height: 16),
                  txtPassword(),
                  const SizedBox(height: 32),
                  botoningresar(),
                ],
              ),
            ),
          ),
          copyright(),
        ],
      ),
    );
  }

  Widget txtUsuario() {
    return TextFormField(
      controller: controllerUsuario,
      decoration: const InputDecoration(
        labelText: 'Usuario',
      ),
    );
  }

  Widget txtPassword() {
    return TextFormField(
      controller: controllerPassword,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Image.asset(
            'assets/logos/eye-slash.jpeg',
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }

  Future<void> verificarlogin() async {
    //  Validación: campos vacíos
    if (controllerUsuario.text.trim().isEmpty ||
        controllerPassword.text.trim().isEmpty) {
      mostrarmensaje(
          'ERROR', 'Por favor, ingresa usuario y contraseña', DialogType.error);
      return;
    }
    final url = Uri.parse(
        "http://localhost/Asistencia/api/usuariosapp.php?accion=login");

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
        // Si la solicitud fue exitosa
        final data = json.decode(response.body);

        if (data['success']) {
          mostrarmensaje('Login', data['message'],
              DialogType.success); // "Credenciales correctas"
        } else {
          mostrarmensaje('Login', data['message'],
              DialogType.error); // "Credenciales incorrectas"
        }
      } else {
        // Si la solicitud no fue exitosa, muestra un error
        mostrarmensaje('Error', 'Error en la solicitud: ${response.statusCode}',
            DialogType.error);
      }
    } catch (e) {
      // Si hay un error en la conexión o en el formato de la solicitud
      mostrarmensaje(
          'Error', 'Error al conectarse al servidor: $e', DialogType.error);
    }
  }

  Widget botoningresar() {
    return Estilosbotones.btnprimary('Ingresar', verificarlogin);
  }

/*
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
*/
  void mostrarmensaje(String titulo, String mensaje, DialogType tipo) {
    AwesomeDialog(
      context: context,
      dialogType: tipo,
      animType: AnimType.bottomSlide,
      title: titulo,
      desc: mensaje,
      btnOkOnPress: () {},
    ).show();
  }

  Widget logo() {
    return Image.asset(
      'assets/logos/apple-touch-icon.png',
      height: 100,
      fit: BoxFit.contain,
    );
  }

  Widget copyright() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        "Copyright © 2025 SEISMEXICO | Versión 0.1.9.2 | 9/5/2025",
        textAlign: TextAlign.center,
      ),
    );
  }
}
