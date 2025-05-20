// Importa el paquete dart:async para trabajar con operaciones asíncronas.
// Este paquete proporciona clases y funciones para manejar operaciones que toman tiempo.
import 'dart:async';
// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa el archivo de configuración de la aplicación.
// Este archivo contiene configuraciones globales para la aplicación.
import 'package:flutter_application_asistencia/config.dart';
// Importa el paquete para manejar preferencias compartidas en la aplicación.
// SharedPreferences permite almacenar datos persistentes simples en el dispositivo.
import 'package:shared_preferences/shared_preferences.dart';
// Importa el paquete http para realizar solicitudes HTTP.
// Este paquete se usa para hacer solicitudes a servidores web.
import 'package:http/http.dart' as http; // Se importa con alias 'http' para evitar conflictos de nombres.

// Define una clase `configuracioncontroller` que maneja la lógica de configuración.
// Esta clase controla la configuración de la dirección del servidor y la conexión.
class configuracioncontroller {
  // Controlador para el campo de texto de la dirección del servidor.
  // TextEditingController se usa para controlar el texto en un campo de entrada.
  final TextEditingController direccioncontroller = TextEditingController();
  // Variable para almacenar el protocolo (http o https).
  // Se inicializa con 'http' como valor predeterminado.
  String protocolo = 'http';
  // ValueNotifier para manejar una lista de mensajes de conexión.
  // ValueNotifier es un objeto observable que notifica a los listeners cuando su valor cambia.
  final ValueNotifier<List<String>> mensajesconexion = ValueNotifier([]);

  // Constructor de la clase.
  // Se ejecuta cuando se crea una instancia de la clase.
  configuracioncontroller() {
    // Llama al método para cargar la dirección guardada.
    _cargardireccionguardada();
  }

  // Método privado para agregar un mensaje a la lista de mensajes de conexión.
  // Este método actualiza el ValueNotifier con un nuevo mensaje.
  void _agregarmensaje(String mensaje) {
    // Actualiza el valor del ValueNotifier añadiendo el nuevo mensaje a la lista existente.
    // El operador spread [...] copia los elementos de la lista actual.
    mensajesconexion.value = [...mensajesconexion.value, mensaje];
    // Imprime el mensaje en la consola para depuración.
    print(mensaje);
  }

  // Método privado asíncrono para cargar la dirección guardada en las preferencias compartidas.
  // 'async' indica que este método puede contener operaciones asíncronas.
  void _cargardireccionguardada() async {
    // Obtiene una instancia de SharedPreferences.
    // SharedPreferences es un almacenamiento simple de clave-valor persistente.
    final prefs = await SharedPreferences.getInstance();
    // Obtiene la dirección limpia guardada, usando una cadena vacía si es nula.
    // El operador ?? devuelve el valor a la izquierda si no es nulo, de lo contrario, devuelve el valor a la derecha.
    final direccionlimpia = prefs.getString('direccion_limpia') ?? '';
    // Establece el texto del controlador con la dirección limpia.
    direccioncontroller.text = direccionlimpia;
    // Obtiene la URL base guardada, usando una cadena vacía si es nula.
    final url = prefs.getString('base_url') ?? '';
    // Determina el protocolo basado en la URL guardada.
    if (url.startsWith('https://')) {
      protocolo = 'https'; // Si la URL comienza con 'https://', establece el protocolo a 'https'.
    } else if (url.startsWith('http://')) {
      protocolo = 'http'; // Si la URL comienza con 'http://', establece el protocolo a 'http'.
    }
  }

  // Método asíncrono para guardar la dirección del servidor.
  // 'async' indica que este método puede contener operaciones asíncronas.
  // 'conexionexitosa' es un parámetro opcional que indica si la conexión fue exitosa.
  Future<void> guardardireccion({bool conexionexitosa = false}) async {
    // Obtiene una instancia de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    // Obtiene la dirección del controlador y elimina los espacios en blanco al inicio y final.
    String direccion = direccioncontroller.text.trim();
    // Guarda la dirección limpia en las preferencias compartidas.
    await prefs.setString('direccion_limpia', direccion);
    // Añade una barra diagonal al final de la dirección si no la tiene.
    if (!direccion.endsWith('/')) {
      direccion += '/';
    }
    // Construye la URL base usando el protocolo y la dirección.
    final url = '$protocolo://$direccion/asistencia/api/';
    // Guarda la URL base en las preferencias compartidas.
    await prefs.setString('base_url', url);
    // Guarda el estado de la conexión en las preferencias compartidas.
    await prefs.setBool('conexion_exitosa', conexionexitosa);
    // Actualiza la URL base en la configuración de la aplicación.
    AppConfig.baseUrl = url;
    // Agrega un mensaje indicando que la dirección fue guardada correctamente.
    _agregarmensaje('💾 Dirección guardada correctamente.');
    // Agrega un mensaje indicando el estado de la conexión guardado.
    _agregarmensaje('📦 Estado de conexión guardado: $conexionexitosa');
  }

  // Método para validar la dirección del servidor.
  // Este método verifica si la dirección es una IP válida o un dominio válido.
  bool validardireccion(String direccion) {
    // Expresión regular para validar una dirección IP con puerto opcional.
    // Ejemplo: 192.168.1.1 o 192.168.1.1:8080
    final ipregexp = RegExp(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?$');
    // Expresión regular para validar un dominio con puerto opcional.
    // Ejemplo: ejemplo.com o ejemplo.com:8080
    final domainregexp = RegExp(r'^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?$');
    // Devuelve true si la dirección coincide con alguna de las expresiones regulares.
    return ipregexp.hasMatch(direccion) || domainregexp.hasMatch(direccion);
  }

  // Método asíncrono para probar la conexión con el servidor.
  // 'async' indica que este método puede contener operaciones asíncronas.
  Future<void> probarconexion() async {
    // Limpia los mensajes anteriores.
    mensajesconexion.value = [];
    // Obtiene la dirección del controlador y elimina los espacios en blanco al inicio y final.
    final direccion = direccioncontroller.text.trim();

    // Valida la dirección.
    if (!validardireccion(direccion)) {
      // Si la dirección no es válida, agrega un mensaje de error.
      _agregarmensaje('❌ Dirección inválida.');
      return; // Sale del método.
    }

    // Si la dirección es válida, agrega un mensaje de éxito.
    _agregarmensaje('✅ Dirección válida: $direccion');
    // Agrega un mensaje indicando que se está preparando la conexión.
    _agregarmensaje('🔧 Preparando conexión...');

    // Construye la URL completa para probar la conexión.
    final urlcompleta = '$protocolo://$direccion/asistencia/api/usuariosapp.php?accion=ping';
    // Agrega un mensaje indicando que se está estableciendo la conexión.
    _agregarmensaje('🔌 Estableciendo conexión con el servidor...');

    try {
      // Convierte la URL completa en un objeto Uri.
      final uri = Uri.parse(urlcompleta);

      // Realiza una solicitud POST a la URL.
      // http.post realiza una solicitud HTTP POST a la URL especificada.
      // headers define los encabezados de la solicitud.
      // timeout establece un tiempo máximo de espera para la respuesta.
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded', // Tipo de contenido de la solicitud.
        },
      ).timeout(const Duration(seconds: 5)); // Tiempo máximo de espera de 5 segundos.

      // Agrega un mensaje indicando que se recibió una respuesta.
      _agregarmensaje('📡 Respuesta recibida (código ${response.statusCode})');

      // Verifica el código de estado de la respuesta.
      if (response.statusCode == 200) {
        // Si el código de estado es 200 (OK), guarda la dirección con conexión exitosa.
        await guardardireccion(conexionexitosa: true);
        // Agrega un mensaje indicando que la conexión fue exitosa.
        _agregarmensaje('✅ Conexión exitosa. Dirección guardada.');
      } else {
        // Si el código de estado no es 200, agrega un mensaje de error.
        _agregarmensaje('⚠ Error HTTP: Código ${response.statusCode}');
      }
    } on TimeoutException {
      // Si ocurre un TimeoutException, agrega un mensaje de error.
      _agregarmensaje('⏱ Tiempo de espera agotado: el servidor no respondió.');
    } on http.ClientException catch (e) {
      // Si ocurre un ClientException, agrega un mensaje de error con el mensaje de la excepción.
      _agregarmensaje('❌ Error de cliente HTTP: ${e.message}');
    } catch (e) {
      // Si ocurre cualquier otra excepción, agrega un mensaje de error con la descripción de la excepción.
      _agregarmensaje('❌ Error desconocido: ${e.toString()}');
    }
  }

  // Método para liberar los recursos.
  // Este método se llama cuando el controlador ya no es necesario.
  void dispose() {
    // Libera los recursos del controlador de texto.
    direccioncontroller.dispose();
    // Libera los recursos del ValueNotifier.
    mensajesconexion.dispose();
  }
}
