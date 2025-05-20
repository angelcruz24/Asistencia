// Importa el paquete base de Flutter que contiene widgets para la interfaz de usuario
import 'package:flutter/material.dart';
// Importa el archivo de configuración donde está la función para cargar la dirección del servidor
import 'package:flutter_application_asistencia/config.dart';
// Importa la vista de login (pantalla de inicio de sesión)
import 'package:flutter_application_asistencia/src/vistas/login.dart';
// Las siguientes líneas están comentadas porque no se usan actualmente,
// pero se pueden habilitar si se desean utilizar esas vistas.
// import 'package:flutter_application_asistencia/src/views/escritorio.dart';
// import 'package:flutter_application_asistencia/src/views/salida.dart'; // Asegúrate de que el nombre del archivo sea correcto

// Función principal que se ejecuta al iniciar la aplicación
Future<void> main() async {
  // Asegura que los widgets estén correctamente vinculados antes de iniciar operaciones asíncronas
  WidgetsFlutterBinding.ensureInitialized();
  // Carga la URL base del servidor desde la configuración
  await AppConfig.loadBaseUrl();
  runApp(const MyApp());  // Ejecuta la aplicación llamando al widget principal MyApp
}

// Clase principal que representa la aplicación completa
class MyApp extends StatelessWidget {
  // Constructor constante (ideal para widgets que no cambian)
  const MyApp({super.key});
  // Método que construye la interfaz de la app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Asistencia', // Título de la app 
      debugShowCheckedModeBanner: false,  // Quita el banner de "debug" que aparece en la esquina superior derecha
      // Define el tema visual de la aplicación (colores, fuentes, etc.)
      theme: ThemeData(
        primarySwatch: Colors.blue, // Color principal (azul en este caso)
      ),
      // Establece la vista inicial al iniciar la app: pantalla de login
      home: const Login(), // Aquí se muestra primero la vista de inicio de sesión
    );
  }
}
