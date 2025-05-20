// Importa el paquete dart:async para trabajar con operaciones asíncronas.
// Este paquete proporciona clases y funciones para manejar operaciones que toman tiempo.
import 'dart:async';
// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa un archivo de funciones personalizadas desde el directorio de servicios de la aplicación.
// Este archivo contiene funciones utilitarias que se usan en la aplicación.
import 'package:flutter_application_asistencia/servicios/funciones.dart';
// Importa el paquete para manejar preferencias compartidas en la aplicación.
// SharedPreferences permite almacenar datos persistentes simples en el dispositivo.
import 'package:shared_preferences/shared_preferences.dart';

// Define una clase `entradacontroller` que maneja la lógica de la vista de entrada.
// Esta clase controla los datos y operaciones relacionadas con el registro de entrada.
class entradacontroller {
  // Controladores para los campos de texto de la vista de entrada.
  // TextEditingController se usa para controlar el texto en un campo de entrada.
  final TextEditingController fechacontroller; // Controlador para el campo de fecha.
  final TextEditingController horacontroller; // Controlador para el campo de hora.
  final TextEditingController ipcontroller; // Controlador para el campo de IP.
  final TextEditingController bssidcontroller; // Controlador para el campo de BSSID.
  final TextEditingController uuidcontroller; // Controlador para el campo de UUID.
  final TextEditingController nombreusuariocontroller; // Controlador para el campo de nombre de usuario.
  final TextEditingController idusuariocontroller; // Controlador para el campo de ID de usuario.

  // Constructor de la clase.
  // Este constructor requiere todos los controladores como parámetros obligatorios.
  entradacontroller({
    required this.fechacontroller, // Parámetro requerido para el controlador de fecha.
    required this.horacontroller, // Parámetro requerido para el controlador de hora.
    required this.ipcontroller, // Parámetro requerido para el controlador de IP.
    required this.bssidcontroller, // Parámetro requerido para el controlador de BSSID.
    required this.uuidcontroller, // Parámetro requerido para el controlador de UUID.
    required this.nombreusuariocontroller, // Parámetro requerido para el controlador de nombre de usuario.
    required this.idusuariocontroller, // Parámetro requerido para el controlador de ID de usuario.
  });

  /// Método principal para cargar todos los datos en la vista.
  /// Este método es asíncrono y carga todos los datos necesarios para la vista de entrada.
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
    nombreusuariocontroller.text = nombreusuario; // Establece el nombre de usuario en el controlador.
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
      fechacontroller.text = datos['fecha'] ?? 'SIN FECHA'; // Establece la fecha o 'SIN FECHA' si es nula.
      horacontroller.text = datos['hora'] ?? 'SIN HORA'; // Establece la hora o 'SIN HORA' si es nula.
    } else {
      // Si los datos no son válidos, establece valores de error en los controladores.
      fechacontroller.text = 'ERROR'; // Establece 'ERROR' en el controlador de fecha.
      horacontroller.text = 'ERROR'; // Establece 'ERROR' en el controlador de hora.
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
    ipcontroller.text = ip; // Establece la IP en el controlador.
    bssidcontroller.text = bssid; // Establece el BSSID en el controlador.
    uuidcontroller.text = uuid; // Establece el UUID en el controlador.
  }

  /// Método asíncrono para registrar la entrada del usuario.
  /// Este método registra la entrada del usuario en el servidor.
  /// 'async' indica que este método puede contener operaciones asíncronas.
  Future<int?> registrar() async {
    // Obtiene el ID del usuario usando la función 'obtenerusuarioid'.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    final idusuario = await obtenerusuarioid();
    // Si el ID del usuario es nulo, devuelve nulo.
    if (idusuario == null) return null;

    // Registra la entrada del usuario usando la función 'registrarentrada'.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    final idasistencia = await registrarentrada(
      idusuario: idusuario, // ID del usuario.
      fechaentrada: fechacontroller.text, // Fecha de entrada.
      horaentrada: horacontroller.text, // Hora de entrada.
      ip: ipcontroller.text, // IP de entrada.
      bssid: bssidcontroller.text, // BSSID de entrada.
      uuid: uuidcontroller.text, // UUID de entrada.
    );

    // Devuelve el ID de asistencia generado si todo fue bien.
    return idasistencia;
  }
}
