// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa un controlador personalizado para el inicio de sesión desde el directorio de controladores de la aplicación.
// Este controlador maneja la lógica de negocio para la vista de inicio de sesión.
import 'package:flutter_application_asistencia/src/controladores/login.dart';
// Importa un archivo que contiene estilos personalizados para los botones.
// Este archivo define estilos reutilizables para los botones en la aplicación.
import 'package:flutter_application_asistencia/src/temas/botones.dart';
// Importa un archivo que contiene el diseño del pie de página de la aplicación.
// Este widget se usa para mostrar información consistente en la parte inferior de la pantalla.
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
// Importa la vista de configuración de la aplicación.
// Esta vista permite a los usuarios configurar la aplicación.
import 'package:flutter_application_asistencia/src/vistas/configuracion.dart';

// Define una clase `Login` que extiende `StatefulWidget`, lo que permite que el widget tenga un estado mutable.
// StatefulWidget es un widget que puede cambiar dinámicamente durante su vida útil.
class Login extends StatefulWidget {
  // Constructor de la clase `Login` que acepta una clave opcional.
  // La palabra clave 'super.key' pasa la clave al constructor de la clase padre (StatefulWidget).
  // 'const' indica que este constructor crea una instancia constante del widget.
  const Login({super.key,});

  // Sobrescribe el método `createState` para devolver una instancia de `Iniciosesion`,
  // que maneja el estado del widget.
  // Este método es llamado por el framework cuando necesita crear el estado para este widget.
  @override
  State<Login> createState() => Iniciosesion();
}

// Define la clase `Iniciosesion` que extiende `State<Login>` y maneja el estado del widget `Login`.
// Esta clase contiene la lógica y el estado mutable para el widget Login.
class Iniciosesion extends State<Login> {
  // Crea una instancia del controlador de inicio de sesión.
  // Este controlador maneja la lógica específica para la vista de inicio de sesión.
  final logincontroller _loginController = logincontroller();
  // Declara una variable para controlar si el texto de la contraseña está oculto.
  // Inicialmente se establece en true para ocultar la contraseña.
  bool _obscureText = true;

  // Sobrescribe el método `dispose` para limpiar los recursos cuando el widget se elimina.
  // Este método se llama cuando el widget se elimina permanentemente del árbol de widgets.
  @override
  void dispose() {
    // Limpia los recursos del controlador.
    _loginController.dispose();
    // Llama al método `dispose` de la clase padre para asegurar que todos los recursos se liberen correctamente.
    super.dispose();
  }

  // Sobrescribe el método `build` para construir la interfaz de usuario del widget.
  // Este método se llama cada vez que el widget necesita ser renderizado.
  // Es el método principal para definir la interfaz de usuario de un widget.
  @override
  Widget build(BuildContext context) {
    // Devuelve un widget `Scaffold` que proporciona una estructura básica para la interfaz de usuario.
    // Scaffold implementa el diseño básico de Material Design, incluyendo AppBar, Body, etc.
    return Scaffold(
      // Define la barra de la aplicación con un título centrado "LOGIN".
      appBar: AppBar(
        // Establece el título de la barra de la aplicación.
        title: const Text('LOGIN'),
        // Centra el título en la barra de la aplicación.
        centerTitle: true,
        // Añade un icono de configuración en el lado izquierdo de la AppBar.
        // Padding añade espacio alrededor de su hijo.
        leading: Padding(
          padding: const EdgeInsets.only(left: 12), // Establece un padding de 12 en el lado izquierdo.
          // GestureDetector es un widget que detecta gestos como toques.
          child: GestureDetector(
            // Define la acción a realizar cuando se toca el icono.
            onTap: () {
              // Navega a la vista de configuración cuando se toca el icono.
              // Navigator.push añade una nueva ruta al stack de navegación.
              // MaterialPageRoute define una transición de página con estilo Material.
              Navigator.push(
                context, // Contexto de navegación.
                MaterialPageRoute(
                  builder: (context) => const configuracion(), // Ruta a la vista de configuración.
                ),
              );
            },
            // Image.asset muestra una imagen desde los assets de la aplicación.
            child: Image.asset(
              'assets/logos/fa-solid fa-gear.png', // Ruta de la imagen en los assets.
              height: 28, // Altura de la imagen.
              width: 28, // Ancho de la imagen.
            ),
          ),
        ),
      ),
      // Define el cuerpo del `Scaffold` como una columna que contiene una lista de widgets hijos.
      body: Column(
        children: [
          // Crea un widget `Expanded` que contiene un `SingleChildScrollView` con un padding de 16 en todos los lados.
          // Expanded hace que su hijo ocupe todo el espacio disponible.
          // SingleChildScrollView permite que el contenido sea desplazable si es más grande que la pantalla.
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16), // Establece un padding de 16 en todos los lados.
              child: Column(
                // Centra los widgets hijos verticalmente.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Añade el logo de la aplicación.
                  logo(),
                  // Añade un espacio de 32 píxeles de altura.
                  const SizedBox(height: 32),
                  // Añade el campo de texto para el usuario.
                  txtUsuario(),
                  // Añade un espacio de 16 píxeles de altura.
                  const SizedBox(height: 16),
                  // Añade el campo de texto para la contraseña.
                  txtPassword(),
                  // Añade un espacio de 32 píxeles de altura.
                  const SizedBox(height: 32),
                  // Añade el botón de ingresar.
                  botoningresar(),
                ],
              ),
            ),
          ),
          // Añade un pie de página al final de la vista.
          // 'Piedepagina' es un widget personalizado que muestra el pie de página.
          // 'const' indica que este widget es constante y no cambiará.
          const Piedepagina(),
        ],
      ),
    );
  }

  // Define un método que devuelve un widget para el campo de texto del usuario.
  // TextFormField es un widget que permite al usuario ingresar texto con validación.
  Widget txtUsuario() {
    return TextFormField(
      // Asigna el controlador de usuario del controlador de inicio de sesión.
      controller: _loginController.controllerusuario,
      // Define la decoración del campo de texto.
      decoration: const InputDecoration(
        labelText: 'Usuario', // Texto de la etiqueta del campo.
      ),
    );
  }

  // Define un método que devuelve un widget para el campo de texto de la contraseña.
  Widget txtPassword() {
    return TextFormField(
      // Asigna el controlador de contraseña del controlador de inicio de sesión.
      controller: _loginController.controllerpassword,
      // Controla si el texto está oculto (para contraseñas).
      obscureText: _obscureText,
      // Define la decoración del campo de texto.
      decoration: InputDecoration(
        labelText: 'Contraseña', // Texto de la etiqueta del campo.
        // Añade un icono al final del campo de texto para mostrar/ocultar la contraseña.
        suffixIcon: GestureDetector(
          // Define la acción a realizar cuando se toca el icono.
          onTap: () {
            // Cambia el estado para mostrar u ocultar la contraseña.
            setState(() {
              _obscureText = !_obscureText; // Invierte el valor de _obscureText.
            });
          },
          // Image.asset muestra una imagen desde los assets de la aplicación.
          child: Image.asset(
            'assets/logos/eye-slash.jpeg', // Ruta de la imagen en los assets.
            height: 20, // Altura de la imagen.
            width: 20, // Ancho de la imagen.
          ),
        ),
      ),
    );
  }

  // Define un método que devuelve un widget para el botón de ingresar.
  // Este método usa un estilo de botón personalizado.
  Widget botoningresar() {
    return Estilosbotones.btnprimary(
      'INGRESAR', // Texto del botón.
      // Define la acción a realizar cuando se presiona el botón.
      () => _loginController.verificarlogin(context), // Llama al método para verificar el inicio de sesión.
    );
  }

  // Define un método que devuelve un widget para el logo de la aplicación.
  Widget logo() {
    return Image.asset(
      'assets/logos/apple-touch-icon.png', // Ruta de la imagen en los assets.
      height: 100, // Altura de la imagen.
      // Ajusta la imagen dentro del espacio disponible.
      fit: BoxFit.contain,
    );
  }
}
