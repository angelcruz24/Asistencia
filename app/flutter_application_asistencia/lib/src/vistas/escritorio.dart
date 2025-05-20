// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa un archivo de funciones personalizadas desde el directorio de servicios de la aplicación.
// Este archivo contiene funciones utilitarias que se usan en la aplicación.
import 'package:flutter_application_asistencia/servicios/funciones.dart';
// Importa un archivo que contiene estilos personalizados para los botones.
// Este archivo define estilos reutilizables para los botones en la aplicación.
import 'package:flutter_application_asistencia/src/temas/botones.dart';
// Importa un archivo que contiene el diseño del pie de página de la aplicación.
// Este widget se usa para mostrar información consistente en la parte inferior de la pantalla.
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
// Importa la vista de entrada de la aplicación.
// Esta vista permite a los usuarios registrar su entrada.
import 'package:flutter_application_asistencia/src/vistas/entrada.dart';
// Importa la vista de inicio de sesión de la aplicación.
// Esta vista permite a los usuarios autenticarse en la aplicación.
import 'package:flutter_application_asistencia/src/vistas/login.dart';
// Importa la vista de salida de la aplicación.
// Esta vista permite a los usuarios registrar su salida.
import 'package:flutter_application_asistencia/src/vistas/salida.dart';

// Define una clase `escritorio` que extiende `StatelessWidget`.
// StatelessWidget es un widget que no tiene estado mutable y se construye una sola vez con los parámetros proporcionados.
// Es ideal para vistas que no necesitan cambiar su estado internamente.
class escritorio extends StatelessWidget {
  // Define una propiedad final para el nombre de usuario que se pasará al widget.
  // 'final' indica que esta propiedad no puede ser modificada después de ser inicializada.
  // Esta propiedad se usa para mostrar el nombre del usuario en la interfaz.
  final String nombreusuario;

  // Constructor de la clase `escritorio` que acepta una clave opcional y un nombre de usuario requerido.
  // La palabra clave 'super.key' pasa la clave al constructor de la clase padre (StatelessWidget).
  // 'required this.nombreusuario' indica que el nombre de usuario es un parámetro obligatorio.
  // 'const' indica que este constructor crea una instancia constante del widget.
  const escritorio({super.key, required this.nombreusuario});

  // Sobrescribe el método `build` para construir la interfaz de usuario del widget.
  // Este método se llama cada vez que el widget necesita ser renderizado.
  // Es el método principal para definir la interfaz de usuario de un widget.
  // Devuelve un widget que representa la interfaz de usuario de este widget.
  @override
  Widget build(BuildContext context) {
    // Devuelve un widget `Scaffold` que proporciona una estructura básica para la interfaz de usuario.
    // Scaffold implementa el diseño básico de Material Design, incluyendo AppBar, Body, etc.
    // En este caso, solo usamos el body y el bottomNavigationBar.
    return Scaffold(
      // Define el cuerpo del `Scaffold` como un `Center` que centra su contenido.
      // Center es un widget que centra su hijo tanto horizontal como verticalmente.
      // Esto hace que todo el contenido esté centrado en la pantalla.
      body: Center(
        // Añade un padding horizontal de 25.0 al contenido.
        // Padding es un widget que añade espacio alrededor de su hijo.
        // EdgeInsets.symmetric(horizontal: 25.0) añade 25 píxeles de padding a izquierda y derecha.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          // Usa una columna para organizar los widgets verticalmente.
          // Column organiza sus hijos en una lista vertical.
          child: Column(
            // Centra los widgets hijos verticalmente.
            // Esto hace que los widgets se distribuyan verticalmente en el centro de la pantalla.
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Añade un texto de bienvenida con estilo en negrita y tamaño 24.
              // Text es un widget que muestra una cadena de texto con un estilo.
              // 'const' indica que este widget es constante y no cambiará.
              const Text(
                "BIENVENIDO", // Texto a mostrar.
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo del texto.
              ),
              // Añade un espacio de 30 píxeles de altura.
              // SizedBox es un widget que ocupa un espacio específico.
              // En este caso, añade un espacio vertical entre widgets.
              const SizedBox(height: 30),

              // Añade un texto alineado a la izquierda para la etiqueta "USUARIO:".
              // Align es un widget que alinea su hijo según la alineación especificada.
              const Align(
                alignment: Alignment.centerLeft, // Alinea el contenido a la izquierda.
                child: Text(
                  "USUARIO:", // Texto a mostrar.
                  style: TextStyle(fontSize: 14), // Estilo del texto.
                ),
              ),
              // Añade un espacio de 5 píxeles de altura.
              const SizedBox(height: 5),
              // Añade un campo de texto para mostrar el nombre de usuario.
              // TextField es un widget que permite al usuario ingresar texto.
              // En este caso, está deshabilitado para solo mostrar información.
              TextField(
                enabled: false, // Deshabilita la edición del campo de texto.
                // Inicializa el controlador con el nombre de usuario.
                // TextEditingController controla el texto en un campo de texto.
                controller: TextEditingController(text: nombreusuario),
                decoration: const InputDecoration(
                  filled: true, // Rellena el campo de texto.
                  fillColor: Color.fromARGB(255, 255, 255, 255), // Color de relleno blanco.
                  border: OutlineInputBorder(), // Borde rectangular.
                  contentPadding: EdgeInsets.symmetric(horizontal: 10), // Padding horizontal interno.
                ),
              ),
              // Añade un espacio de 30 píxeles de altura.
              const SizedBox(height: 30),

              // Botón REGISTRAR ENTRADA
              // Estilosbotones.btnsuccess es un método personalizado que crea un botón con estilo de éxito.
              // Este botón permite al usuario registrar su entrada.
              Estilosbotones.btnsuccess(
                "REGISTRAR ENTRADA", // Texto del botón.
                () async { // Función que se ejecuta cuando se presiona el botón.
                  // Obtiene el ID del usuario de manera asíncrona.
                  // 'await' espera a que la operación asíncrona se complete antes de continuar.
                  // obtenerusuarioid() es una función asíncrona que devuelve el ID del usuario.
                  final idusuario = await obtenerusuarioid();
                  // Obtiene la fecha y hora actuales de manera asíncrona.
                  // obtenerfechahora() es una función asíncrona que devuelve un mapa con la fecha y hora.
                  final fechahora = await obtenerfechahora();
                  // Extrae la fecha del mapa, usando una cadena vacía si es nulo.
                  // El operador ?? devuelve el valor a la izquierda si no es nulo, de lo contrario, devuelve el valor a la derecha.
                  final fecha = fechahora['fecha'] ?? '';

                  // Verifica si el ID de usuario o la fecha son nulos o vacíos.
                  if (idusuario == null || fecha.isEmpty) {
                    // Muestra un mensaje de error si no se pudo obtener el ID de usuario o la fecha.
                    // mensajeescritorio es una función personalizada que muestra un mensaje en la pantalla.
                    mensajeescritorio(context, 'Error', 'No se pudo obtener el ID de usuario o la fecha');
                    return; // Sale de la función.
                  }

                  // Consulta si el usuario ya tiene una entrada registrada para la fecha actual.
                  // consultarentrada es una función asíncrona que verifica si hay una entrada registrada.
                  final yatieneentrada = await consultarentrada(idusuario: idusuario, fecha: fecha);

                  // Si ya tiene una entrada registrada, muestra un mensaje.
                  if (yatieneentrada) {
                    mensajeescritorio(context, 'Entrada ya registrada', 'Ya has registrado tu entrada hoy.');
                  } else {
                    // Si no tiene una entrada registrada, navega a la vista de entrada.
                    // Navigator.push añade una nueva ruta al stack de navegación.
                    // MaterialPageRoute define una transición de página con estilo Material.
                    Navigator.push(
                      context, // Contexto de navegación.
                      MaterialPageRoute(
                        builder: (context) => entrada(nombreusuario: nombreusuario), // Ruta a la vista de entrada.
                      ),
                    );
                  }
                },
              ),
              // Añade un espacio de 20 píxeles de altura.
              const SizedBox(height: 20),

              // Botón REGISTRAR SALIDA
              // Estilosbotones.btnwarning es un método personalizado que crea un botón con estilo de advertencia.
              // Este botón permite al usuario registrar su salida.
              Estilosbotones.btnwarning(
                "REGISTRAR SALIDA", // Texto del botón.
                () async { // Función que se ejecuta cuando se presiona el botón.
                  // Obtiene el ID del usuario de manera asíncrona.
                  final idusuario = await obtenerusuarioid();
                  // Obtiene la fecha y hora actuales de manera asíncrona.
                  final fechahora = await obtenerfechahora();
                  // Extrae la fecha del mapa, usando una cadena vacía si es nulo.
                  final fecha = fechahora['fecha'] ?? '';

                  // Verifica si el ID de usuario o la fecha son nulos o vacíos.
                  if (idusuario == null || fecha.isEmpty) {
                    // Muestra un mensaje de error si no se pudo obtener el ID de usuario o la fecha.
                    mensajeescritorio(context, 'Error', 'No se pudo obtener el ID de usuario o la fecha');
                    return; // Sale de la función.
                  }

                  // Consulta si el usuario ya tiene una entrada registrada para la fecha actual.
                  final tieneentrada = await consultarentrada(idusuario: idusuario, fecha: fecha);

                  // Si no tiene una entrada registrada, muestra un mensaje.
                  if (!tieneentrada) {
                    // msjescritorio es una función personalizada que muestra un mensaje en la pantalla.
                    // Nota: Parece haber un error tipográfico en el nombre de la función (debería ser mensajeescritorio).
                    msjescritorio(context, 'No hay entrada registrada', 'Primero debes registrar la entrada para poder registrar la salida.');
                  } else {
                    // Si tiene una entrada registrada, navega a la vista de salida.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => salida(nombreusuario: nombreusuario), // Ruta a la vista de salida.
                      ),
                    );
                  }
                },
              ),
              // Añade un espacio de 20 píxeles de altura.
              const SizedBox(height: 20),

              // Botón SALIR DE LA APP
              // Estilosbotones.btnlight es un método personalizado que crea un botón con estilo claro.
              // Este botón permite al usuario salir de la aplicación.
              Estilosbotones.btnlight(
                "SALIR DE LA APP", // Texto del botón.
                () { // Función que se ejecuta cuando se presiona el botón.
                  // Navega a la vista de inicio de sesión, reemplazando la vista actual.
                  // Navigator.push añade una nueva ruta al stack de navegación.
                  // MaterialPageRoute define una transición de página con estilo Material.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(), // Ruta a la vista de inicio de sesión.
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // Añade un pie de página al final de la vista.
      // 'Piedepagina' es un widget personalizado que muestra el pie de página.
      // 'const' indica que este widget es constante y no cambiará.
      bottomNavigationBar: const Piedepagina(),
    );
  }
}
