// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa un archivo de funciones personalizadas desde el directorio de servicios de la aplicación.
// Este archivo contiene funciones utilitarias que se usan en la aplicación.
import 'package:flutter_application_asistencia/servicios/funciones.dart';
// Importa el paquete para manejar preferencias compartidas en la aplicación.
// SharedPreferences permite almacenar datos persistentes simples en el dispositivo.
import 'package:shared_preferences/shared_preferences.dart';

// Define una clase `salidacontroller` que maneja la lógica de la vista de salida.
// Esta clase controla los datos y operaciones relacionadas con el registro de salida.
class salidacontroller {
  // Controladores para los campos de texto de la vista de salida.
  // TextEditingController se usa para controlar el texto en un campo de entrada.
  final TextEditingController idusuariocontroller; // Controlador para el campo de ID de usuario.
  final TextEditingController usuariocontroller; // Controlador para el campo de usuario.
  final TextEditingController fechasalidacontroller; // Controlador para el campo de fecha de salida.
  final TextEditingController horasalidacontroller; // Controlador para el campo de hora de salida.
  final TextEditingController ipsalidacontroller; // Controlador para el campo de IP de salida.
  final TextEditingController bssidsalidadcontroller; // Controlador para el campo de BSSID de salida.
  final TextEditingController uuisalidacontroller; // Controlador para el campo de UUID de salida.
  final TextEditingController actividadescontroller; // Controlador para el campo de actividades.

  // Constructor de la clase.
  // Este constructor requiere todos los controladores como parámetros obligatorios.
  salidacontroller({
    required this.idusuariocontroller, // Parámetro requerido para el controlador de ID de usuario.
    required this.usuariocontroller, // Parámetro requerido para el controlador de usuario.
    required this.fechasalidacontroller, // Parámetro requerido para el controlador de fecha de salida.
    required this.horasalidacontroller, // Parámetro requerido para el controlador de hora de salida.
    required this.ipsalidacontroller, // Parámetro requerido para el controlador de IP de salida.
    required this.bssidsalidadcontroller, // Parámetro requerido para el controlador de BSSID de salida.
    required this.uuisalidacontroller, // Parámetro requerido para el controlador de UUID de salida.
    required this.actividadescontroller, // Parámetro requerido para el controlador de actividades.
  });

  /// Método principal para cargar todos los datos en la vista.
  /// Este método es asíncrono y carga todos los datos necesarios para la vista de salida.
  /// 'async' indica que este método puede contener operaciones asíncronas.
  Future<void> cargarDatos() async {
    // Carga los datos del usuario desde las preferencias compartidas.
    await _cargardatosusuario();
    // Obtiene la fecha y hora del servidor.
    await _obtenerfechahoraservidor();
    // Obtiene los datos del dispositivo (IP, BSSID, UUID).
    await _obtenerdatosdispositivo();
  }

  /// Método privado asíncrono para cargar los datos del usuario desde SharedPreferences.
  /// Este método obtiene el ID y nombre del usuario guardados en las preferencias compartidas.
  /// 'async' indica que este método puede contener operaciones asíncronas.
  Future<void> _cargardatosusuario() async {
    // Obtiene una instancia de SharedPreferences.
    // SharedPreferences es un almacenamiento simple de clave-valor persistente.
    final prefs = await SharedPreferences.getInstance();
    // Obtiene el ID del usuario, usando 0 si es nulo.
    // El operador ?? devuelve el valor a la izquierda si no es nulo, de lo contrario, devuelve el valor a la derecha.
    final idusuario = prefs.getInt('usuarioid') ?? 0;
    // Obtiene el nombre del usuario, usando una cadena vacía si es nulo.
    final nombreusuario = prefs.getString('usuarionombre') ?? '';

    // Establece el texto de los controladores con los valores obtenidos.
    idusuariocontroller.text = idusuario.toString(); // Convierte el ID a cadena y lo establece en el controlador.
    usuariocontroller.text = nombreusuario; // Establece el nombre de usuario en el controlador.
  }

  /// Método privado asíncrono para obtener la fecha y hora del servidor.
  /// Este método usa la función 'obtenerfechahora' para obtener la fecha y hora actuales del servidor.
  /// 'async' indica que este método puede contener operaciones asíncronas.
  Future<void> _obtenerfechahoraservidor() async {
    // Obtiene la fecha y hora del servidor usando la función 'obtenerfechahora'.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    final datos = await obtenerfechahora();
    // Imprime los datos obtenidos en la consola para depuración.
    print("Datos desde el servidor: $datos");

    // Verifica si los datos obtenidos son válidos.
    if (datos['fecha'] != 'Error' && datos['hora'] != 'Error') {
      // Si los datos son válidos, establece los valores en los controladores.
      fechasalidacontroller.text = datos['fecha'] ?? 'SIN FECHA'; // Establece la fecha o 'SIN FECHA' si es nula.
      horasalidacontroller.text = datos['hora'] ?? 'SIN HORA'; // Establece la hora o 'SIN HORA' si es nula.
    } else {
      // Si los datos no son válidos, establece valores de error en los controladores.
      fechasalidacontroller.text = 'ERROR'; // Establece 'ERROR' en el controlador de fecha.
      horasalidacontroller.text = 'ERROR'; // Establece 'ERROR' en el controlador de hora.
    }
  }

  /// Método privado asíncrono para obtener datos del dispositivo.
  /// Este método obtiene la IP, BSSID y UUID del dispositivo.
  /// 'async' indica que este método puede contener operaciones asíncronas.
  Future<void> _obtenerdatosdispositivo() async {
    // Obtiene la IP del dispositivo usando la función 'obtenerip'.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    final ip = await obtenerip();
    // Obtiene el BSSID del dispositivo usando la función 'obtenerbssid'.
    final bssid = await obtenerbssid();
    // Obtiene el UUID del dispositivo usando la función 'obteneruuid'.
    final uuid = await obteneruuid();

    // Establece los valores obtenidos en los controladores.
    ipsalidacontroller.text = ip; // Establece la IP en el controlador.
    bssidsalidadcontroller.text = bssid; // Establece el BSSID en el controlador.
    uuisalidacontroller.text = uuid; // Establece el UUID en el controlador.
  }

  /// Método asíncrono para registrar la salida del usuario.
  /// Este método registra la salida del usuario en el servidor.
  /// 'async' indica que este método puede contener operaciones asíncronas.
  Future<bool> registrarsalidaapi() async {
    // Obtiene una instancia de SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    // Obtiene el ID de asistencia guardado en las preferencias compartidas.
    final idasistencia = prefs.getInt('idasistencia');

    // Verifica si el ID de asistencia es nulo.
    if (idasistencia == null) {
      // Si el ID de asistencia es nulo, imprime un mensaje de error y devuelve false.
      print('No se encontró el ID de asistencia en SharedPreferences');
      return false;
    }

    // Obtiene los valores de los controladores.
    final fecha = fechasalidacontroller.text; // Fecha de salida.
    final hora = horasalidacontroller.text; // Hora de salida.
    final ip = ipsalidacontroller.text; // IP de salida.
    final bssid = bssidsalidadcontroller.text; // BSSID de salida.
    final uuid = uuisalidacontroller.text; // UUID de salida.
    final actividades = actividadescontroller.text; // Actividades realizadas.

    // Verifica si la fecha o la hora están vacías.
    if (fecha.isEmpty || hora.isEmpty) {
      return false; // Devuelve false si los datos son inválidos.
    }

    // Registra la salida del usuario usando la función 'registrarsalida'.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    final exito = await registrarsalida(
      idasistencia: idasistencia, // ID de asistencia.
      fechasalida: fecha, // Fecha de salida.
      horasalida: hora, // Hora de salida.
      ipsalida: ip, // IP de salida.
      bssidsalida: bssid, // BSSID de salida.
      uuidsalida: uuid, // UUID de salida.
      actividades: actividades, // Actividades realizadas.
    );

    // Si el registro fue exitoso, elimina el ID de asistencia de las preferencias compartidas.
    if (exito) {
      await prefs.remove('idasistencia'); // Elimina el ID de asistencia.
      print('ID de asistencia eliminado de SharedPreferences'); // Imprime un mensaje de éxito.
    }

    // Devuelve el resultado del registro.
    return exito;
  }

  // Método para liberar los recursos.
  // Este método se llama cuando el controlador ya no es necesario.
  void dispose() {
    // Libera los recursos de los controladores.
    idusuariocontroller.dispose(); // Libera el controlador de ID de usuario.
    usuariocontroller.dispose(); // Libera el controlador de usuario.
    fechasalidacontroller.dispose(); // Libera el controlador de fecha de salida.
    horasalidacontroller.dispose(); // Libera el controlador de hora de salida.
    ipsalidacontroller.dispose(); // Libera el controlador de IP de salida.
    bssidsalidadcontroller.dispose(); // Libera el controlador de BSSID de salida.
    uuisalidacontroller.dispose(); // Libera el controlador de UUID de salida.
    actividadescontroller.dispose(); // Libera el controlador de actividades.
  }
}
