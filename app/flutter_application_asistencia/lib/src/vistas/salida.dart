// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa un archivo de funciones personalizadas desde el directorio de servicios de la aplicación.
// Este archivo contiene funciones utilitarias que se usan en la aplicación.
import 'package:flutter_application_asistencia/servicios/funciones.dart';
// Importa un controlador personalizado para la salida desde el directorio de controladores de la aplicación.
// Este controlador maneja la lógica de negocio para la vista de salida.
import 'package:flutter_application_asistencia/src/controladores/salida.dart';
// Importa un archivo que contiene estilos personalizados para los botones.
// Este archivo define estilos reutilizables para los botones en la aplicación.
import 'package:flutter_application_asistencia/src/temas/botones.dart';
// Importa un archivo que contiene el diseño del pie de página de la aplicación.
// Este widget se usa para mostrar información consistente en la parte inferior de la pantalla.
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
// Importa la vista de escritorio de la aplicación.
// Esta vista es la pantalla principal después del inicio de sesión.
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
// Importa el paquete para manejar permisos en la aplicación con un alias 'ph'.
// Este paquete se usa para solicitar permisos del sistema al usuario.
import 'package:permission_handler/permission_handler.dart' as ph;

// Define una clase `salida` que extiende `StatefulWidget`, lo que permite que el widget tenga un estado mutable.
// StatefulWidget es un widget que puede cambiar dinámicamente durante su vida útil.
class salida extends StatefulWidget {
  // Define una propiedad final para el nombre de usuario que se pasará al widget.
  // 'final' indica que esta propiedad no puede ser modificada después de ser inicializada.
  final String nombreusuario;

  // Constructor de la clase `salida` que acepta una clave opcional y un nombre de usuario requerido.
  // La palabra clave 'super.key' pasa la clave al constructor de la clase padre (StatefulWidget).
  // 'required this.nombreusuario' indica que el nombre de usuario es un parámetro obligatorio.
  // 'const' indica que este constructor crea una instancia constante del widget.
  const salida({super.key, required this.nombreusuario});

  // Sobrescribe el método `createState` para devolver una instancia de `_SalidaState`,
  // que maneja el estado del widget.
  // Este método es llamado por el framework cuando necesita crear el estado para este widget.
  @override
  State<salida> createState() => _SalidaState();
}

// Define la clase `_SalidaState` que extiende `State<salida>` y maneja el estado del widget `salida`.
// Esta clase contiene la lógica y el estado mutable para el widget salida.
class _SalidaState extends State<salida> {
  // Declara controladores para los campos de texto.
  // 'late' indica que estas variables se inicializarán más tarde, antes de usarse.
  // TextEditingController se usa para controlar el texto en un campo de entrada.
  late TextEditingController idusuariocontroller; // Controlador para el campo de ID de usuario.
  late TextEditingController usuariocontroller; // Controlador para el campo de usuario.
  late TextEditingController fechasalidacontroller; // Controlador para el campo de fecha de salida.
  late TextEditingController horasalidacontroller; // Controlador para el campo de hora de salida.
  late TextEditingController ipsalidacontroller; // Controlador para el campo de IP de salida.
  late TextEditingController bssidsalidadcontroller; // Controlador para el campo de BSSID de salida.
  late TextEditingController uuisalidacontroller; // Controlador para el campo de UUID de salida.
  late TextEditingController actividadescontroller; // Controlador para el campo de actividades.
  // Declara una instancia del controlador de salida.
  // Este controlador maneja la lógica específica para la vista de salida.
  late salidacontroller controller;

  // Sobrescribe el método `initState` para inicializar el estado del widget.
  // Este método se llama cuando el widget se inserta en el árbol de widgets.
  // Es el lugar adecuado para inicializar controladores y realizar configuraciones iniciales.
  @override
  void initState() {
    super.initState(); // Llama al método `initState` de la clase padre para asegurar la inicialización adecuada.

    // Inicializa los controladores de texto.
    idusuariocontroller = TextEditingController(); // Inicializa el controlador de ID de usuario.
    usuariocontroller = TextEditingController(); // Inicializa el controlador de usuario.
    fechasalidacontroller = TextEditingController(); // Inicializa el controlador de fecha de salida.
    horasalidacontroller = TextEditingController(); // Inicializa el controlador de hora de salida.
    ipsalidacontroller = TextEditingController(); // Inicializa el controlador de IP de salida.
    bssidsalidadcontroller = TextEditingController(); // Inicializa el controlador de BSSID de salida.
    uuisalidacontroller = TextEditingController(); // Inicializa el controlador de UUID de salida.
    actividadescontroller = TextEditingController(); // Inicializa el controlador de actividades.

    // Inicializa el controlador de salida con los controladores de texto.
    // Este controlador personalizado maneja la lógica específica para esta vista.
    controller = salidacontroller(
      idusuariocontroller: idusuariocontroller, // Pasa el controlador de ID de usuario.
      usuariocontroller: usuariocontroller, // Pasa el controlador de usuario.
      fechasalidacontroller: fechasalidacontroller, // Pasa el controlador de fecha de salida.
      horasalidacontroller: horasalidacontroller, // Pasa el controlador de hora de salida.
      ipsalidacontroller: ipsalidacontroller, // Pasa el controlador de IP de salida.
      bssidsalidadcontroller: bssidsalidadcontroller, // Pasa el controlador de BSSID de salida.
      uuisalidacontroller: uuisalidacontroller, // Pasa el controlador de UUID de salida.
      actividadescontroller: actividadescontroller, // Pasa el controlador de actividades.
    );

    // Solicita permisos y carga los datos.
    _solicitarPermisos(); // Llama al método para solicitar permisos.
    _cargarDatos(); // Llama al método para cargar los datos.
  }

  // Define un método asíncrono para solicitar permisos.
  // 'async' indica que este método puede contener operaciones asíncronas.
  // Un método asíncrono puede realizar operaciones que toman tiempo (como I/O) sin bloquear el hilo principal.
  Future<void> _solicitarPermisos() async {
    // Solicita permiso para acceder a la ubicación cuando la aplicación está en uso.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    // En este caso, espera a que el usuario responda a la solicitud de permiso.
    // ph.Permission.locationWhenInUse.request() muestra un diálogo al usuario solicitando permiso para acceder a la ubicación.
    // Se usa el alias 'ph' para el paquete permission_handler.
    await ph.Permission.locationWhenInUse.request();
  }

  // Define un método asíncrono para cargar los datos.
  // 'async' indica que este método puede contener operaciones asíncronas.
  // Este método realiza operaciones que pueden tomar tiempo, como acceder a datos o servicios.
  Future<void> _cargarDatos() async {
    // Carga los datos usando el controlador.
    // 'await' espera a que la operación asíncrona se complete antes de continuar.
    // controller.cargarDatos() es un método asíncrono que carga datos necesarios para la vista.
    await controller.cargarDatos();
    // Refresca la interfaz de usuario con los nuevos valores si el widget está montado.
    // 'mounted' es una propiedad que indica si el widget está actualmente en el árbol de widgets.
    // setState() notifica al framework que el estado ha cambiado y necesita reconstruir el widget.
    if (mounted) setState(() {});
  }

  // Sobrescribe el método `build` para construir la interfaz de usuario del widget.
  // Este método se llama cada vez que el widget necesita ser renderizado.
  // Es el método principal para definir la interfaz de usuario de un widget.
  @override
  Widget build(BuildContext context) {
    // Devuelve un widget `Scaffold` que proporciona una estructura básica para la interfaz de usuario.
    // Scaffold implementa el diseño básico de Material Design, incluyendo AppBar, Body, etc.
    return Scaffold(
      // Define la barra de la aplicación con un título centrado "SALIDA".
      appBar: AppBar(
        // Establece el título de la barra de la aplicación con estilo en negrita y tamaño 24.
        title: const Text('SALIDA',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        // Centra el título en la barra de la aplicación.
        centerTitle: true,
        // Establece el color de fondo de la barra de la aplicación a blanco.
        backgroundColor: Colors.white,
        // Establece la elevación de la barra de la aplicación a 0 (sin sombra).
        elevation: 0,
      ),
      // Define el cuerpo del `Scaffold` como un `SingleChildScrollView` con padding de 20 en todos los lados.
      // 'SingleChildScrollView' permite que el contenido sea desplazable si es más grande que la pantalla.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20), // Establece un padding de 20 en todos los lados.
        child: Column(
          // Alinea los widgets hijos al inicio (izquierda).
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Añade campos de entrada para ID de usuario, usuario, fecha de salida, hora de salida,
            // IP de salida, BSSID de salida y UUID de salida.
            // Cada campo de entrada se crea llamando al método `_campoEntrada` con una etiqueta y un controlador.
            _campoEntrada("ID USUARIO:", controller.idusuariocontroller),
            _campoEntrada("USUARIO:", controller.usuariocontroller),
            _campoEntrada("FECHA SALIDA:", controller.fechasalidacontroller),
            _campoEntrada("HORA SALIDA:", controller.horasalidacontroller),
            _campoEntrada("IP SALIDA:", controller.ipsalidacontroller),
            _campoEntrada("BSSID SALIDA:", controller.bssidsalidadcontroller),
            _campoEntrada("UUI SALIDA:", controller.uuisalidacontroller),
            // Añade un espacio de 20 píxeles de altura.
            const SizedBox(height: 20),
            // Añade un campo de entrada para las actividades realizadas.
            // Este campo es diferente porque permite múltiples líneas de texto.
            _actividadesRealizadas(controller.actividadescontroller),
            // Añade un espacio de 30 píxeles de altura.
            const SizedBox(height: 30),
            // Centra los botones de registrar salida y regresar.
            Center(
              child: Column(
                children: [
                  // Añade un botón de éxito para registrar la salida.
                  // 'Estilosbotones.btnsuccess' es un método personalizado que crea un botón con estilo de éxito.
                  // Este botón permite al usuario registrar su salida.
                  Estilosbotones.btnsuccess(
                    "REGISTRAR SALIDA", // Texto del botón.
                    () async { // Función que se ejecuta cuando se presiona el botón.
                      // Registra la salida de manera asíncrona.
                      // 'await' espera a que la operación asíncrona se complete antes de continuar.
                      // registrarsalidas es una función asíncrona que registra la salida del usuario.
                      await registrarsalidas(
                        context, // Contexto de la aplicación, necesario para mostrar diálogos o navegar.
                        fechasalidacontroller, // Controlador de fecha de salida.
                        horasalidacontroller, // Controlador de hora de salida.
                        ipsalidacontroller, // Controlador de IP de salida.
                        bssidsalidadcontroller, // Controlador de BSSID de salida.
                        uuisalidacontroller, // Controlador de UUID de salida.
                        actividadescontroller, // Controlador de actividades.
                        widget.nombreusuario, // Nombre de usuario, pasado al widget.
                      );
                    },
                  ),
                  // Añade un espacio de 15 píxeles de altura.
                  const SizedBox(height: 15),
                  // Añade un botón de peligro para regresar a la vista de escritorio.
                  // 'Estilosbotones.btndanger' es un método personalizado que crea un botón con estilo de peligro.
                  // Este botón permite al usuario volver a la vista de escritorio.
                  Estilosbotones.btndanger(
                    "REGRESAR", // Texto del botón.
                    () { // Función que se ejecuta cuando se presiona el botón.
                      // Navega a la vista de escritorio, reemplazando la vista actual.
                      // Navigator.pushReplacement reemplaza la ruta actual en el stack de navegación.
                      // Esto significa que el usuario no podrá volver a esta vista usando el botón de retroceso.
                      Navigator.pushReplacement(
                        context, // Contexto de navegación.
                        MaterialPageRoute(
                          builder: (context) => escritorio(
                            nombreusuario: widget.nombreusuario, // Ruta a la vista de escritorio.
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Añade un pie de página al final de la vista.
      // 'Piedepagina' es un widget personalizado que muestra el pie de página.
      // 'const' indica que este widget es constante y no cambiará.
      bottomNavigationBar: const Piedepagina(),
    );
  }

  // Define un método que devuelve un widget para un campo de entrada.
  // Este método crea un campo de entrada con una etiqueta y un controlador.
  // Los campos de entrada son widgets que permiten al usuario ingresar datos.
  Widget _campoEntrada(String etiqueta, TextEditingController controlador) {
    // Devuelve un widget `Padding` con un padding de 15 en la parte inferior.
    // Padding añade espacio alrededor de su hijo.
    return Padding(
      padding: const EdgeInsets.only(bottom: 15), // Establece un padding de 15 en la parte inferior.
      child: Column(
        // Alinea los widgets hijos al inicio (izquierda).
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Añade un texto en negrita para la etiqueta.
          // Text es un widget que muestra una cadena de texto con un estilo.
          Text(
            etiqueta, // Texto a mostrar.
            style: const TextStyle(fontWeight: FontWeight.bold), // Estilo de texto en negrita.
          ),
          // Añade un espacio de 5 píxeles de altura.
          // SizedBox es un widget que ocupa un espacio específico.
          const SizedBox(height: 5),
          // Añade un campo de texto con el controlador proporcionado.
          // TextField es un widget que permite al usuario ingresar texto.
          TextField(
            controller: controlador, // Asigna el controlador al campo de texto.
            // Establece el campo de texto como de solo lectura (no editable).
            // Esto significa que el usuario no puede modificar el texto directamente.
            readOnly: true,
            decoration: InputDecoration(
              // Establece el campo de texto como relleno.
              // Esto da al campo de texto un fondo.
              filled: true,
              // Establece el color de relleno a blanco.
              // Color.fromARGB(255, 255, 255, 255) es blanco con opacidad completa.
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              // Establece el borde del campo de texto con un radio de 5.
              // OutlineInputBorder crea un borde rectangular con esquinas redondeadas.
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5), // Radio de 5 para las esquinas redondeadas.
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Define un método que devuelve un widget para el campo de actividades realizadas.
  // Este método es similar a _campoEntrada pero permite múltiples líneas de texto.
  Widget _actividadesRealizadas(TextEditingController controller) {
    // Devuelve un widget `Padding` con un padding de 15 en la parte inferior.
    return Padding(
      padding: const EdgeInsets.only(bottom: 15), // Establece un padding de 15 en la parte inferior.
      child: Column(
        // Alinea los widgets hijos al inicio (izquierda).
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Añade un texto en negrita para la etiqueta.
          const Text(
            "ACTIVIDADES REALIZADAS:", // Texto a mostrar.
            style: TextStyle(fontWeight: FontWeight.bold), // Estilo de texto en negrita.
          ),
          // Añade un espacio de 5 píxeles de altura.
          const SizedBox(height: 5),
          // Añade un campo de texto con el controlador proporcionado.
          // Este campo de texto permite múltiples líneas.
          TextField(
            controller: controller, // Asigna el controlador al campo de texto.
            // Establece el número máximo de líneas a 4.
            // Esto permite al usuario ingresar múltiples líneas de texto.
            maxLines: 4,
            decoration: InputDecoration(
              // Establece el campo de texto como relleno.
              filled: true,
              // Establece el color de relleno a blanco.
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              // Establece el borde del campo de texto con un radio de 5.
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5), // Radio de 5 para las esquinas redondeadas.
              ),
            ),
          ),
        ],
      ),
    );
  }
}
