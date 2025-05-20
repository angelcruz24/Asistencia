// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa el paquete dart:convert para manejar la codificación y decodificación de JSON.
// Este paquete proporciona funciones para convertir entre JSON y objetos Dart.
import 'dart:convert';
// Importa el paquete awesome_dialog para mostrar diálogos personalizados.
// AwesomeDialog proporciona diálogos con animaciones y estilos personalizados.
import 'package:awesome_dialog/awesome_dialog.dart';
// Importa el archivo de configuración de la aplicación.
// Este archivo contiene configuraciones globales para la aplicación.
import 'package:flutter_application_asistencia/config.dart';
// Importa la vista de escritorio de la aplicación.
// Esta vista es la pantalla principal después del inicio de sesión.
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
// Importa el paquete http para realizar solicitudes HTTP.
// Este paquete se usa para hacer solicitudes a servidores web.
import 'package:http/http.dart' as http; // Se importa con alias 'http' para evitar conflictos de nombres.
// Importa el paquete para manejar preferencias compartidas en la aplicación.
// SharedPreferences permite almacenar datos persistentes simples en el dispositivo.
import 'package:shared_preferences/shared_preferences.dart';

// Define una clase `logincontroller` que maneja la lógica de inicio de sesión.
// Esta clase controla los datos y operaciones relacionadas con el inicio de sesión.
class logincontroller {
  // Controladores para los campos de texto de usuario y contraseña.
  // TextEditingController se usa para controlar el texto en un campo de entrada.
  final TextEditingController controllerusuario = TextEditingController(); // Controlador para el campo de usuario.
  final TextEditingController controllerpassword = TextEditingController(); // Controlador para el campo de contraseña.

  // Método para liberar los recursos.
  // Este método se llama cuando el controlador ya no es necesario.
  void dispose() {
    // Libera los recursos del controlador de usuario.
    controllerusuario.dispose();
    // Libera los recursos del controlador de contraseña.
    controllerpassword.dispose();
  }

  // Método asíncrono para verificar el inicio de sesión.
  // Este método valida los datos de inicio de sesión y realiza la solicitud al servidor.
  // 'async' indica que este método puede contener operaciones asíncronas.
  Future<void> verificarlogin(BuildContext context) async {
    // Verifica si la URL base está vacía.
    if (AppConfig.baseUrl.trim().isEmpty) {
      // Si la URL base está vacía, muestra un mensaje de advertencia.
      mostrarmensaje(
        context,
        'Sin conexión', // Título del mensaje.
        'Primero debes establecer una conexión al servidor desde la configuración.', // Mensaje del diálogo.
        DialogType.warning, // Tipo de diálogo (advertencia).
      );
      return; // Sale del método.
    }
    // Verifica si los campos de usuario o contraseña están vacíos.
    if (controllerusuario.text.trim().isEmpty ||
        controllerpassword.text.trim().isEmpty) {
      // Si algún campo está vacío, muestra un mensaje de error.
      mostrarmensaje(
          context,
          'ERROR', // Título del mensaje.
          'Por favor, ingresa usuario y contraseña', // Mensaje del diálogo.
          DialogType.error // Tipo de diálogo (error).
      );
      return; // Sale del método.
    }

    // Construye la URL para la solicitud de inicio de sesión.
    // Uri.parse convierte una cadena en un objeto Uri.
    final url = Uri.parse(
        "${AppConfig.baseUrl}usuariosapp.php?accion=login"); // URL para la solicitud de inicio de sesión.

    try {
      // Realiza una solicitud POST a la URL.
      // http.post realiza una solicitud HTTP POST a la URL especificada.
      // headers define los encabezados de la solicitud.
      // body define el cuerpo de la solicitud, codificado como JSON.
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"}, // Tipo de contenido de la solicitud.
        body: json.encode({
          'nombre': controllerusuario.text.trim(), // Nombre de usuario.
          'clave': controllerpassword.text.trim(), // Contraseña.
        }),
      );

      // Verifica el código de estado de la respuesta.
      if (response.statusCode == 200) {
        // Si el código de estado es 200 (OK), decodifica el cuerpo de la respuesta.
        final data = json.decode(response.body); // Decodifica el cuerpo de la respuesta como JSON.

        // Verifica si el inicio de sesión fue exitoso.
        if (data['success']) {
          // Conversión segura del ID de usuario.
          // int.tryParse convierte una cadena en un entero, usando 0 si falla.
          int idusuario = int.tryParse(data['id'].toString()) ?? 0;
          // Obtiene el nombre de usuario, usando el nombre ingresado si es nulo.
          String nombreusuario = data['nombre']?.toString() ?? controllerusuario.text.trim();

          // Obtiene una instancia de SharedPreferences.
          final prefs = await SharedPreferences.getInstance();
          // Guarda el ID de usuario en las preferencias compartidas.
          await prefs.setInt('usuarioid', idusuario);
          // Guarda el nombre de usuario en las preferencias compartidas.
          await prefs.setString('usuarionombre', nombreusuario);

          // Navega a la vista de escritorio.
          // Navigator.push añade una nueva ruta al stack de navegación.
          // MaterialPageRoute define una transición de página con estilo Material.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => escritorio(nombreusuario: nombreusuario), // Ruta a la vista de escritorio.
            ),
          );
        } else {
          // Si el inicio de sesión no fue exitoso, muestra un mensaje de error.
          mostrarmensaje(
            context,
            'Login', // Título del mensaje.
            data['message'], // Mensaje del diálogo.
            DialogType.error // Tipo de diálogo (error).
          );
        }
      } else {
        // Si el código de estado no es 200, muestra un mensaje de error.
        mostrarmensaje(
          context,
          'Error', // Título del mensaje.
          'Error en la solicitud: ${response.statusCode}', // Mensaje del diálogo.
          DialogType.error // Tipo de diálogo (error).
        );
      }
    } catch (e) {
      // Si ocurre una excepción, muestra un mensaje de error.
      mostrarmensaje(
        context,
        'Error', // Título del mensaje.
        'Error al conectarse al servidor: $e', // Mensaje del diálogo.
        DialogType.error // Tipo de diálogo (error).
      );
    }
  }

  // Método para mostrar un mensaje en un diálogo.
  // Este método usa AwesomeDialog para mostrar un diálogo personalizado.
  void mostrarmensaje(
      BuildContext context, // Contexto de la aplicación.
      String titulo, // Título del mensaje.
      String mensaje, // Mensaje del diálogo.
      DialogType tipo // Tipo de diálogo (error, advertencia, éxito, etc.).
  ) {
    // Crea y muestra un diálogo AwesomeDialog.
    AwesomeDialog(
      context: context, // Contexto de la aplicación.
      dialogType: tipo, // Tipo de diálogo.
      animType: AnimType.bottomSlide, // Tipo de animación (deslizamiento desde abajo).
      title: titulo, // Título del diálogo.
      desc: mensaje, // Mensaje del diálogo.
      btnOkOnPress: () {}, // Acción al presionar el botón OK.
    ).show(); // Muestra el diálogo.
  }
}
