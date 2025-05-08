import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController controllerUsuario = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();


@override
void dispose() {
  controllerUsuario.dispose();
  controllerPassword.dispose();
  super.dispose();
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black, // Fondo negro
    appBar: AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.settings,
          color: Colors.purple, // Ícono morado
        ),
        onPressed: () {
          // Aquí puedes navegar a Configuración u otra pantalla
        },
      ),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: columna(),
      ),
    ),
  );
}


  Widget columna() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        divisor(80),
        logo(),
        divisor(40),
        txtUsuario(),
        divisor(10),
        divisor(10),
        txtPassword(),
        const SizedBox(height: 50),
        botonIngresar(),
      ],
    );
  }


  Widget logo() {
    return Image.asset(
      'assets/logos/apple-touch-icon.png',
      height: 100,
      fit: BoxFit.contain,
    );
  }



  Widget txtUsuario() {
  return TextFormField(
    controller: controllerUsuario,
    style: const TextStyle(color: Colors.white), // Texto ingresado en blanco
    cursorColor: Colors.white, // Cursor blanco
    decoration: InputDecoration(
      labelText: 'Usuario',
      labelStyle: const TextStyle(color: Colors.white), // Etiqueta en blanco
      prefixIcon: const Icon(
        Icons.person, // Ícono nativo
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    autocorrect: false,
  );
}



  Widget txtPassword() {
  return TextFormField(
    controller: controllerPassword,
    style: const TextStyle(color: Colors.white), // Texto ingresado en blanco
    obscureText: true,
    decoration: InputDecoration(
      labelText: 'Contraseña',
      labelStyle: const TextStyle(color: Colors.white), // Etiqueta en blanco
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white), // Borde cuando no está enfocado
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white), // Borde cuando está enfocado
      ),
      prefixIcon: const Icon(
        Icons.lock,
        color: Colors.white, // Ícono en blanco si lo quieres
      ),
    ),
  );
}


  Widget divisor(double altura) {
  return SizedBox(height: altura);
}

  Widget botonIngresar() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 163, 95, 95),
      minimumSize: const Size(double.infinity, 50),
),
      child: const Text(
        'Ingresar',
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget copyright() {
    return const Text(" copyright"
    );
  }

}