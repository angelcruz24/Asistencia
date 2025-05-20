// Importa la librería para codificar y decodificar datos JSON (usada en peticiones HTTP y respuestas).
import 'dart:convert';
// Importa herramientas para manejar operaciones asincrónicas (como Future y Stream).
import 'dart:async';
// Importa funciones para interactuar con el sistema operativo (como verificar la plataforma: Android/iOS).
import 'dart:io';
// Importa la librería de AwesomeDialog para mostrar diálogos con estilo en la app (información, errores, alertas).
import 'package:awesome_dialog/awesome_dialog.dart';
// Importa los widgets y clases principales de Flutter para construir interfaces gráficas.
import 'package:flutter/material.dart';
// Importa el archivo de configuración personalizado, donde probablemente se define la URL base del servidor.
import 'package:flutter_application_asistencia/config.dart';
// Importa la vista del escritorio, que se muestra después de iniciar sesión (pantalla principal del usuario).
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
// Importa la librería http para hacer peticiones HTTP (como POST para login, GET para datos).
import 'package:http/http.dart' as http;
// Importa SharedPreferences para guardar información localmente (como ID de usuario, nombre, etc.).
import 'package:shared_preferences/shared_preferences.dart';
// Importa NetworkInfo para obtener datos de red como dirección IP, nombre de red (SSID), BSSID, etc.
import 'package:network_info_plus/network_info_plus.dart';
// Importa DeviceInfo para obtener información específica del dispositivo (como ID de Android o iOS).
import 'package:device_info_plus/device_info_plus.dart';
// Importa WiFiScan para escanear redes WiFi disponibles y verificar si hay permisos para hacerlo.
import 'package:wifi_scan/wifi_scan.dart';

// Función que obtiene la fecha y hora actual desde el servidor, desde API
Future<Map<String, String>> obtenerfechahora() async {
  try {
    // Verifica si la URL base está vacía
    if (AppConfig.baseUrl.isEmpty) {
      return {'fecha': 'No URL', 'hora': 'No URL'}; 
    }
    // Construye la URL para la petición
    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=fechahora');
    final response = await http.get(url).timeout(const Duration(seconds: 5)); // Hace la solicitud GET al servidor, con un límite de espera de 5 segundos.
    // Si el servidor responde correctamente
    if (response.statusCode == 200) {
      final data = json.decode(response.body);  // Decodifica la respuesta JSON.
      return {
        // Retorna un mapa con la fecha y hora recibidas del servidor.
        'fecha': data['fecha'] ?? 'Fecha inválida',
        'hora': data['hora'] ?? 'Hora inválida'
      };
    } else {
      // Si la respuesta no fue exitosa, retorna error.
      return {'fecha': 'Error', 'hora': 'Error'};
    }
  } catch (_) {
    // Si ocurre alguna excepción como error de red, también retorna error.
    return {'fecha': 'Error', 'hora': 'Error'};
  }
}

// Obtener el ID del usuario desde SharedPreferences
Future<int?> obtenerusuarioid() async {
  final prefs = await SharedPreferences.getInstance();  // Obtiene la instancia de SharedPreferences para acceder a datos guardados localmente.
  return prefs.getInt('usuarioid'); // Lee el valor almacenado bajo la clave idusuario
}

// Verificar si ya existe una entrada registrada para un usuario en una fecha específica
Future<bool> consultarentrada({required int idusuario, required String fecha}) async {
  try {
    // Verifica que la URL base no esté vacía.
    if (AppConfig.baseUrl.isEmpty) return false;
     // Construye la URL para la consulta, enviando el ID de usuario y la acción consultarentrada
    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=consultarentrada');
    final response = await http.post(
      url,
      body: jsonEncode({'idusuario': idusuario, 'fechaentrada': fecha}),
      headers: {'Content-Type': 'application/json'},
    );
    // Si la respuesta es exitosa, analiza el cuerpo.
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['success'] == true;
    }
    return false; // Si la respuesta no es 200, considera que no hay registro.
  } catch (_) {
    return false; // Si hubo error timeout, red, JSON mal formado, retorna false.
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
    // Verifica que la URL base esté definida.
    if (AppConfig.baseUrl.isEmpty) return null;
    // Construye la URL para registrar entrada.
    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=guardarentrada');
    // Envía la petición POST con cuerpo codificado en formato application/JSON
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
    // Imprimir en la consola de depuracion el codigo del estado y la respuesta del servidor 
    print('Código de estado: ${response.statusCode}');
    print('Respuesta del servidor: ${response.body}');
    // Si la respuesta es exitosa (código 200), regresa un true y el id del registro
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {    // Registro exitoso.
        return data['id'];
      }
    }
    return null;    // No se registró correctamente.
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
    // Verifica que la URL base esté configurada; si no, no puede continuar.
    if (AppConfig.baseUrl.isEmpty) return false;
    // Construye la URL para el endpoint PHP que guardará la salida.
    final url = Uri.parse('${AppConfig.baseUrl}usuariosapp.php?accion=guardarsalida');
    // Imprime la URL a donde estamos enviando y enviandfo datos
    print('URL: $url');
    print('Enviando datos al servidor...');
    // Envía una petición POST con un cuerpo JSON con los datos de salida
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
      headers: {'Content-Type': 'application/json'},  // Indica que el cuerpo es JSON
    );
    // Imprime el código HTTP de la respuesta y la del servidor
    print('Código de estado: ${response.statusCode}');
    print('Respuesta del servidor: ${response.body}');
    // Devuelve true si el código es 200 y el JSON de respuesta tiene success == true.
    return response.statusCode == 200 &&
           json.decode(response.body)['success'] == true;
  } catch (e) {
    // Si ocurre algún error en la red o JSON lo imprime y devuelve false.
    print('Error en registrarsalida: $e');
    return false;
  }
}


//MENSAJE DE ENTRADA\\
// Muestra un diálogo tipo AwesomeDialog con título, mensaje, tipo y acción opcional al presionar OK.
// Donde tiene como parámetros:
// - context: contexto de Flutter donde se mostrará el diálogo.
// - titulo: texto para el título del diálogo.
// - mensaje: texto para la descripción del diálogo.
// - tipo: tipo de diálogo (info, error, success, etc.) - valor por defecto es info.
// - onOkPress: función callback para cuando se presiona el botón OK (opcional).
void mostrarmensaje({
  required BuildContext context,
  required String titulo,
  required String mensaje,
  DialogType tipo = DialogType.info,
  VoidCallback? onOkPress, // Callback opcional para botón OK.
}) {
  AwesomeDialog(
    context: context,
    dialogType: tipo,              // Tipo de diálogo (error, info, success, etc.)
    animType: AnimType.bottomSlide, // Animación de aparición
    title: titulo,                  // Título que se muestra en el diálogo
    desc: mensaje,                 // Mensaje de descripción
    btnOkText: "Aceptar",          // Texto del botón
    btnOkColor: const Color.fromRGBO(31, 206, 7, 0.658), // Color del botón OK
    btnOkOnPress: onOkPress ?? () {}, // Acción al pulsar OK o función vacía si no se pasa callback
    dismissOnTouchOutside: false,  // No se puede cerrar tocando fuera del diálogo
  ).show();                        // Muestra el diálogo
}


// Función que registra la entrada del usuario con datos recibidos desde los controladores de texto.
// Parámetros:
// - context: contexto de Flutter para mostrar diálogos y navegación.
// - fechacontroller, horacontroller, ipcontroller, bssidcontroller, uuidcontroller: controladores de texto con datos.
// - nombreusuario: nombre del usuario para pasar a la siguiente pantalla.
Future<Object?> registrar(
  BuildContext context,
  dynamic fechacontroller,
  dynamic horacontroller,
  dynamic ipcontroller,
  dynamic bssidcontroller,
  dynamic uuidcontroller,
  String nombreusuario, // Nombre del usuario para pasar a la siguiente pantalla
) async {
  // Obtiene el ID y nombre del usuario almacenados localmente.
  final idusuario = await obtenerusuarioid();
  if (idusuario == null) {
    // Si no se pudo obtener el ID, muestra un mensaje de error y termina.
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se pudo obtener el ID del usuario.",
      tipo: DialogType.error,
    );
    return false;
  }

  // Llama a la función para registrar entrada enviando los datos obtenidos de los controladores.
  final exito = await registrarentrada(
    idusuario: idusuario,
    fechaentrada: fechacontroller.text,
    horaentrada: horacontroller.text,
    ip: ipcontroller.text,
    bssid: bssidcontroller.text,
    uuid: uuidcontroller.text,
  );
  // Si exito no es nulo, considera que fue exitosa la operación.
  if (exito != null) {
    // Guarda el ID de asistencia en SharedPreferences para usarlo luego en salida.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idasistencia', exito);
    // Muestra mensaje de éxito y redirige al escritorio cuando se presiona "Aceptar".
    mostrarmensaje(
      context: context,
      titulo: "Éxito",
      mensaje: "Entrada registrada correctamente.",
      tipo: DialogType.success,
      onOkPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => escritorio(nombreusuario: nombreusuario),
          ),
        );
      },
    );
  } else {
    // Si no fue exitoso, muestra mensaje de error.
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se pudo registrar la entrada.",
      tipo: DialogType.error,
    );
  }

  return exito;
}

// Función que registra la salida del usuario con datos de controladores y SharedPreferences.
Future<Object?> registrarsalidas(
  BuildContext context,
  TextEditingController fechasalidacontroller, 
  TextEditingController horasalidacontroller,
  TextEditingController ipsalidacontroller,
  TextEditingController bssidsalidadcontroller,
  TextEditingController uuisalidacontroller,
  TextEditingController actividadescontroller,
  String nombreusuario, 
) async {
  // Obtiene el ID de asistencia previamente guardado en SharedPreferences.
  final prefs = await SharedPreferences.getInstance();
  final idasistencia = prefs.getInt('idasistencia');
  // Si no se encontró el ID, muestra mensaje de error y termina.
  if (idasistencia == null) {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se encontró el ID de asistencia en SharedPreferences.",
      tipo: DialogType.error,
    );
    return false;
  }
  // Obtiene los valores de los controladores de texto para fecha, hora, IP, BSSID, UUID y actividades.
  final fecha = fechasalidacontroller.text;
  final hora = horasalidacontroller.text;
  final ip = ipsalidacontroller.text;
  final bssid = bssidsalidadcontroller.text;
  final uuid = uuisalidacontroller.text;
  final actividades = actividadescontroller.text;
  // Verifica que los campos obligatorios estén completos.
  if (fecha.isEmpty || hora.isEmpty || actividades.isEmpty) {
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "Complete todos los campos obligatorios.",
      tipo: DialogType.error,
    );
    return false;
  }
  // Llama a la función que registra la salida enviando los datos.
  final exito = await registrarsalida(
    idasistencia: idasistencia,
    fechasalida: fecha,
    horasalida: hora,
    ipsalida: ip,
    bssidsalida: bssid,
    uuidsalida: uuid,
    actividades: actividades,
  );
  // Si fue exitoso, elimina el ID de asistencia de SharedPreferences y muestra mensaje de éxito.
  if (exito) {
    await prefs.remove('idasistencia');
    mostrarmensaje(
      context: context,
      titulo: "Éxito",
      mensaje: "Salida registrada correctamente.",
      tipo: DialogType.success,
      onOkPress: () { // Navega al escritorio tras aceptar.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => escritorio(nombreusuario: nombreusuario),
          ),
        );
      },
    );
  } else {
    // Si hubo error, muestra mensaje de error.
    mostrarmensaje(
      context: context,
      titulo: "Error",
      mensaje: "No se pudo registrar la salida.",
      tipo: DialogType.error,
    );
  }

  return exito;
}

// Muestra un diálogo de error en el escritorio con título y mensaje.
void mensajeescritorio(BuildContext context, String titulo, String mensaje) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error, // Tipo error
    animType: AnimType.bottomSlide,
    title: titulo,
    desc: mensaje,
    btnOkOnPress: () {}, // Acción vacía al pulsar OK
  ).show();
}

// Función que muestra un diálogo informativo tipo AwesomeDialog en el contexto dado.
void msjescritorio(BuildContext context, String titulo, String mensaje) {
  AwesomeDialog(
    context: context,              // Contexto donde se muestra el diálogo
    dialogType: DialogType.info,   // Tipo de diálogo (info)
    animType: AnimType.bottomSlide, // Animación al aparecer (deslizando desde abajo)
    title: titulo,                 // Título del diálogo (variable)
    desc: mensaje,                // Descripción/mensaje del diálogo (variable)
    btnOkOnPress: () {},          // Acción vacía al presionar el botón OK
  ).show();                       // Muestra el diálogo
}


///////////////////////////////
/// FUNCIONES DE DISPOSITIVO ///
///////////////////////////////

// Obtiene la dirección IP del dispositivo conectado a la red WiFi.
Future<String> obtenerip() async {
  try {
    final info = NetworkInfo(); // Crea instancia para obtener info de red
    final ip = await info.getWifiIP();  // Intenta obtener la IP WiFi del dispositivo
    return ip ?? 'No disponible';   // Retorna la IP o 'No disponible' si es null
  } catch (e) {
    // En caso de error, imprime el error en consola
    print('Error al obtener IP: $e');
    return 'Error'; // Retorna 'Error' indicando que hubo un fallo
  }
}

// Obtiene el BSSID (MAC del punto de acceso WiFi) al que está conectado el dispositivo.
Future<String> obtenerbssid() async {
  try {
    // Verifica si se puede iniciar un escaneo WiFi (permiso)
    final canScan = await WiFiScan.instance.canStartScan();
    if (canScan == CanStartScan.yes) {  // Si se permite escanear
      await WiFiScan.instance.startScan();  // Inicia el escaneo WiFi
      // Espera 2 segundos para que el escaneo tenga tiempo de completar
      await Future.delayed(const Duration(seconds: 2));
      final bssid = await NetworkInfo().getWifiBSSID(); // Obtiene el BSSID de la red WiFi actual
      return bssid ?? 'No disponible';  // Retorna el BSSID o mensaje si no está disponible
    } else {
      // Si no tiene permiso para escanear, retorna mensaje correspondiente
      return 'Permiso denegado';
    }
  } catch (e) {
    // Si hay un error, imprime en consola
    print('Error al obtener BSSID: $e');
    // Retorna mensaje de error
    return 'Error';
  }
}

// Obtiene el identificador único del dispositivo (UUID).
// En Android devuelve androidInfo.id, en iOS devuelve identifierForVendor.
Future<String> obteneruuid() async {
  try {
    // Crea instancia para obtener info del dispositivo
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) { // Si la plataforma es Android
      final androidInfo = await deviceInfo.androidInfo; // Obtiene info específica de Android
      return androidInfo.id;  // Retorna el ID único del dispositivo Android
    }
    // Si la plataforma es iOS
    else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo; // Obtiene info específica de iOS
      // Retorna identificador para el proveedor o mensaje si no está disponible
      return iosInfo.identifierForVendor ?? 'No disponible';
    }
    // Si no es Android ni iOS, retorna plataforma desconocida
    return 'Plataforma desconocida';
  } catch (e) {
    // Si ocurre un error, imprime el error en consola
    print('Error al obtener UUID: $e');
    // Retorna mensaje de error
    return 'Error';
  }
}
