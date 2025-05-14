import 'package:flutter/material.dart';
import 'package:flutter_application_asistencia/src/controladores/login.dart';
import 'package:flutter_application_asistencia/src/temas/botones.dart';
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
import 'package:flutter_application_asistencia/src/vistas/configuracion.dart';


class Login extends StatefulWidget {
  const Login({super.key,});

  @override
  State<Login> createState() => Iniciosesion();
}

class Iniciosesion extends State<Login> {
  final LoginController _loginController = LoginController();
  bool _obscureText = true;

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('LOGIN'),
         centerTitle: true,
  leading: Padding(
    padding: const EdgeInsets.only(left: 12),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Configuracion()), // Asegúrate de tener esta clase creada
        );
      },
      child: Image.asset(
        'assets/logos/fa-solid fa-gear.png',
        height: 28,
        width: 28,
      ),
    ),
  ),
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
          const Piedepagina(),
        ],
      ),
    );
  }

  Widget txtUsuario() {
    return TextFormField(
      controller: _loginController.controllerUsuario,
      decoration: const InputDecoration(
        labelText: 'Usuario',
      ),
    );
  }

  Widget txtPassword() {
    return TextFormField(
      controller: _loginController.controllerPassword,
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

  Widget botoningresar() {
    return Estilosbotones.btnprimary(
        'INGRESAR', () => _loginController.verificarlogin(context));
  }

  Widget logo() {
    return Image.asset(
      'assets/logos/apple-touch-icon.png',
      height: 100,
      fit: BoxFit.contain,
    );
  }
}
