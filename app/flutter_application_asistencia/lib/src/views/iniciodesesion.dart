import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/temas/colorBotones.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _IniciodeSesion();
}

class _IniciodeSesion extends State<Login> {
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
                  botonIngresar(),
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

  Future<void> verificarLogin() async {
    final url = Uri.parse("http://127.0.0.1/Asistencia/api/usuariosapp.php?accion=login"); // Cambiar por la IP correcta si es necesario

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
          showMessage(data['message']); // "Credenciales correctas"
        } else {
          showMessage(data['message']); // "Credenciales incorrectas"
        }
      } else {
        // Si la solicitud no fue exitosa, muestra un error
        showMessage('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Si hay un error en la conexión o en el formato de la solicitud
      showMessage('Error al conectarse al servidor: $e');
    }
  }



  Widget botonIngresar() {
    return EstilosDeBotones.btnSecondary(
      'Ingresar', () {
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
        "Copyright © 2025 | Versión 1.9.9.2 - 9/5/2025",
        textAlign: TextAlign.center,
      ),
    );
  }
}