// Importa SharedPreferences para guardar información localmente (como ID de usuario, nombre, etc.).
import 'package:shared_preferences/shared_preferences.dart';
/// Clase de configuración global que almacena la URL base del servidor
class AppConfig {
  /// URL base que se usará para todas las peticiones HTTP
  static String baseUrl = '';
  /// Lee la URL base que se guardó en SharedPreferences y la asigna a la variable baseUrl
  /// Debe llamarse una vez al arrancar la app, en main()
  static Future<void> loadBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    // Obtiene la cadena con la clave 'base_url'; si no existe, usa ''.
    baseUrl = prefs.getString('base_url') ?? '';
  }
  /// Guarda la URL base en SharedPreferences y actualiza la variable baseUrl para que se muestre en toda la aplicación.
  /// Se invoca desde la vista de Configuración cuando la conexión al servidor se ha hecho.
  static Future<void> saveBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    // Se guarda la URL para que esté disponible para inicios de sesión que se hagan despues.
    await prefs.setString('base_url', url);
    // Actualiza la variable estática en tiempo de ejecución.
    baseUrl = url;
  }
}