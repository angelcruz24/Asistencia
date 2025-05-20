// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
import 'package:flutter/material.dart';
// Importa un controlador personalizado para la configuración desde el directorio de controladores de la aplicación.
import 'package:flutter_application_asistencia/src/controladores/configuracion.dart';
// Importa un archivo que contiene estilos personalizados para los botones.
import 'package:flutter_application_asistencia/src/temas/botones.dart';
// Importa un archivo que contiene el diseño del pie de página de la aplicación.
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
// Importa la vista de inicio de sesión de la aplicación.
import 'package:flutter_application_asistencia/src/vistas/login.dart';

// Define una clase `configuracion` que extiende `StatefulWidget`, lo que permite que el widget tenga un estado mutable.
class configuracion extends StatefulWidget {
  // Constructor de la clase `configuracion` que acepta una clave opcional.
  // La palabra clave 'super.key' pasa la clave al constructor de la clase padre (StatefulWidget).
  const configuracion({super.key});

  // Sobrescribe el método `createState` para devolver una instancia de `_ConfiguracionState`,
  // que maneja el estado del widget.
  @override
  State<configuracion> createState() => _ConfiguracionState();
}

// Define la clase `_ConfiguracionState` que extiende `State<configuracion>` y maneja el estado del widget `configuracion`.
class _ConfiguracionState extends State<configuracion> {
  // Crea una instancia del controlador `configuracioncontroller` para manejar la lógica de la configuración.
  final configuracioncontroller controlador = configuracioncontroller();

  // Sobrescribe el método `dispose` para limpiar los recursos del controlador cuando el widget se elimina del árbol de widgets.
  @override
  void dispose() {
    // Limpia los recursos del controlador.
    controlador.dispose();
    // Llama al método `dispose` de la clase padre para asegurar que todos los recursos se liberen correctamente.
    super.dispose();
  }

  // Sobrescribe el método `build` para construir la interfaz de usuario del widget.
  @override
  Widget build(BuildContext context) {
    // Devuelve un widget `Scaffold` que proporciona una estructura básica para la interfaz de usuario.
    return Scaffold(
      // Define la barra de la aplicación con un título centrado "CONFIGURACION".
      appBar: AppBar(
        // Establece el título de la barra de la aplicación.
        title: const Text('CONFIGURACION'),
        // Centra el título en la barra de la aplicación.
        centerTitle: true,
      ),
      // Define el cuerpo del `Scaffold` como una columna que contiene una lista de widgets hijos.
      body: Column(
        children: [
          // Crea un widget `Expanded` que contiene un `SingleChildScrollView` con un padding de 16 en todos los lados.
          Expanded(
            child: SingleChildScrollView(
              // Establece un padding de 16 en todos los lados.
              padding: const EdgeInsets.all(16),
              child: Column(
                // Estira los widgets hijos horizontalmente.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Llama al método que devuelve un widget para la dirección del servidor.
                  direccionservidor(),
                  // Añade un espacio de 20 píxeles de altura.
                  const SizedBox(height: 20),
                  // Llama al método que devuelve un widget para el botón de conexión.
                  botonconexion(),
                  // Añade un espacio de 20 píxeles de altura.
                  const SizedBox(height: 20),
                  // Llama al método que devuelve un widget para el resultado de la conexión.
                  resultadoconexion(),
                  // Añade un espacio de 20 píxeles de altura.
                  const SizedBox(height: 20),
                  // Llama al método que devuelve un widget para el botón de regresar.
                  botonregresar(context),
                ],
              ),
            ),
          ),
          // Añade un widget `Piedepagina` al final de la columna principal.
          const Piedepagina(),
        ],
      ),
    );
  }

  // Define un método que devuelve un widget para la sección de dirección del servidor.
  Widget direccionservidor() {
    // Devuelve una columna que se alinea al inicio y contiene varios widgets hijos.
    return Column(
      // Alinea los widgets hijos al inicio.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Añade un texto en negrita "Dirección del Servidor".
        const Text(
          'Dirección del Servidor',
          // Estilo de texto en negrita.
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Añade un espacio de 8 píxeles de altura.
        const SizedBox(height: 8),
        // Crea un campo de texto para ingresar la dirección del servidor.
        TextField(
          // Controlador para el campo de texto.
          controller: controlador.direccioncontroller,
          decoration: const InputDecoration(
            // Borde del campo de texto.
            border: OutlineInputBorder(),
            // Texto de sugerencia para el campo de texto.
            hintText: 'Ej. 192.168.1.1:8000 o ejemplo.com',
          ),
        ),
        // Añade un espacio de 10 píxeles de altura.
        const SizedBox(height: 10),
        // Crea un menú desplegable para seleccionar el protocolo (http o https).
        DropdownButtonFormField<String>(
          // Valor actual del protocolo.
          value: controlador.protocolo,
          // Etiqueta del menú desplegable.
          decoration: const InputDecoration(labelText: 'Protocolo'),
          // Opciones del menú desplegable.
          items: const [
            // Opción para http.
            DropdownMenuItem(value: 'http', child: Text('http://')),
            // Opción para https.
            DropdownMenuItem(value: 'https', child: Text('https://')),
          ],
          // Función que se ejecuta cuando se selecciona un valor.
          onChanged: (value) {
            // Actualiza el estado del widget.
            setState(() {
              // Actualiza el protocolo con el valor seleccionado.
              controlador.protocolo = value!;
            });
          },
        ),
      ],
    );
  }

  // Define un método que devuelve un widget para el botón de conexión.
  Widget botonconexion() {
    // Devuelve un botón primario con el texto "PROBAR CONEXION".
    return Estilosbotones.btnprimary(
      // Texto del botón.
      "PROBAR CONEXION",
      // Función que se ejecuta cuando se presiona el botón.
      () async {
        // Prueba la conexión.
        await controlador.probarconexion();
        // Refresca el estado del widget para actualizar la interfaz de usuario.
        setState(() {});
      },
    );
  }

  // Define un método que devuelve un widget para mostrar el resultado de la conexión.
  Widget resultadoconexion() {
    // Devuelve una columna que se alinea al inicio y contiene varios widgets hijos.
    return Column(
      // Alinea los widgets hijos al inicio.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Añade un texto en negrita "RESULTADO DE LA CONEXION".
        const Text(
          'RESULTADO DE LA CONEXION',
          // Estilo de texto en negrita y tamaño 16.
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        // Añade un espacio de 8 píxeles de altura.
        const SizedBox(height: 8),
        // Crea un contenedor con un borde gris y redondeado.
        Container(
          // Altura del contenedor.
          height: 250,
          // Padding de 12 en todos los lados.
          padding: const EdgeInsets.all(12),
          // Decoración del contenedor con borde gris y redondeado.
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          // Contenido del contenedor.
          child: ValueListenableBuilder<List<String>>(
            // Lista de mensajes de conexión que se actualiza dinámicamente.
            valueListenable: controlador.mensajesconexion,
            // Función que construye el contenido del contenedor.
            builder: (context, mensajes, _) {
              // Devuelve una lista de mensajes.
              return ListView(
                children: mensajes
                    .map((mensaje) => Text(
                          // Texto del mensaje.
                          mensaje,
                          // Estilo de texto con tamaño 14.
                          style: const TextStyle(fontSize: 14),
                        ))
                    // Convierte la lista de mensajes en una lista de widgets de texto.
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  // Define un método que devuelve un widget para el botón de regresar.
  Widget botonregresar(BuildContext context) {
    // Devuelve un botón de peligro con el texto "REGRESAR".
    return Estilosbotones.btndanger(
      // Texto del botón.
      "REGRESAR",
      // Función que se ejecuta cuando se presiona el botón.
      () {
        // Navega a la vista de inicio de sesión, reemplazando la vista actual.
        Navigator.pushReplacement(
          context,
          // Ruta a la vista de inicio de sesión.
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
    );
  }
}
