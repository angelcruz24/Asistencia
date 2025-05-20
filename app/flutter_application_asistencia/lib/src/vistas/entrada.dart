// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';
// Importa un archivo de funciones personalizadas desde el directorio de servicios de la aplicación.
// Este archivo contiene funciones utilitarias que se usan en la aplicación.
import 'package:flutter_application_asistencia/servicios/funciones.dart';
// Importa un controlador personalizado para la entrada desde el directorio de controladores de la aplicación.
// Este controlador maneja la lógica de negocio para la vista de entrada.
import 'package:flutter_application_asistencia/src/controladores/entrada.dart';
// Importa un archivo que contiene estilos personalizados para los botones.
// Este archivo define estilos reutilizables para los botones en la aplicación.
import 'package:flutter_application_asistencia/src/temas/botones.dart';
// Importa un archivo que contiene el diseño del pie de página de la aplicación.
// Este widget se usa para mostrar información consistente en la parte inferior de la pantalla.
import 'package:flutter_application_asistencia/src/temas/piedepagina.dart';
// Importa la vista de escritorio de la aplicación.
// Esta vista es la pantalla principal después del inicio de sesión.
import 'package:flutter_application_asistencia/src/vistas/escritorio.dart';
// Importa el paquete para manejar permisos en la aplicación.
// Este paquete se usa para solicitar permisos del sistema al usuario.
import 'package:permission_handler/permission_handler.dart';
// Importa el paquete para manejar preferencias compartidas en la aplicación.
// Este paquete permite almacenar datos persistentes simples en el dispositivo.
import 'package:shared_preferences/shared_preferences.dart';

// Define una clase `entrada` que extiende `StatefulWidget`, lo que permite que el widget tenga un estado mutable.
// StatefulWidget es un widget que puede cambiar dinámicamente durante su vida útil.
class entrada extends StatefulWidget {
  // Define una propiedad final para el nombre de usuario que se pasará al widget.
  // 'final' indica que esta propiedad no puede ser modificada después de ser inicializada.
  final String nombreusuario;

  // Constructor de la clase `entrada` que acepta una clave opcional y un nombre de usuario requerido.
  // La palabra clave 'super.key' pasa la clave al constructor de la clase padre (StatefulWidget).
  // 'required this.nombreusuario' indica que el nombre de usuario es un parámetro obligatorio.
  const entrada({super.key, required this.nombreusuario});

  // Sobrescribe el método `createState` para devolver una instancia de `_EntradaState`,
  // que maneja el estado del widget.
  // Este método es llamado por el framework cuando necesita crear el estado para este widget.
  @override
  State<entrada> createState() => _EntradaState();
}

// Define la clase `_EntradaState` que extiende `State<entrada>` y maneja el estado del widget `entrada`.
// Esta clase contiene la lógica y el estado mutable para el widget entrada.
class _EntradaState extends State<entrada> {
  // Declara controladores para los campos de texto.
  // 'late' indica que estas variables se inicializarán más tarde, antes de usarse.
  // TextEditingController se usa para controlar el texto en un campo de entrada.
  late TextEditingController fechacontroller; // Controlador para el campo de fecha.
  late TextEditingController horacontroller; // Controlador para el campo de hora.
  late TextEditingController ipcontroller; // Controlador para el campo de IP.
  late TextEditingController bssidcontroller; // Controlador para el campo de BSSID.
  late TextEditingController uuicontroller; // Controlador para el campo de UUID.
  late TextEditingController idusuariocontroller; // Controlador para el campo de ID de usuario.
  late TextEditingController nombreusuariocontroller; // Controlador para el campo de nombre de usuario.
  // Declara una instancia del controlador de entrada.
  // Este controlador maneja la lógica específica para la vista de entrada.
  late entradacontroller controller;

  // Sobrescribe el método `initState` para inicializar el estado del widget.
  // Este método se llama cuando el widget se inserta en el árbol de widgets.
  // Es el lugar adecuado para inicializar controladores y realizar configuraciones iniciales.
  @override
  void initState() {
    super.initState(); // Llama al método `initState` de la clase padre para asegurar la inicialización adecuada.

    // Inicializa los controladores de texto.
    fechacontroller = TextEditingController(); // Inicializa el controlador de fecha.
    horacontroller = TextEditingController(); // Inicializa el controlador de hora.
    ipcontroller = TextEditingController(); // Inicializa el controlador de IP.
    bssidcontroller = TextEditingController(); // Inicializa el controlador de BSSID.
    uuicontroller = TextEditingController(); // Inicializa el controlador de UUID.
    idusuariocontroller = TextEditingController(); // Inicializa el controlador de ID de usuario.
    nombreusuariocontroller = TextEditingController(); // Inicializa el controlador de nombre de usuario.

    // Inicializa el controlador de entrada con los controladores de texto.
    // Este controlador personalizado maneja la lógica específica para esta vista.
    controller = entradacontroller(
      fechacontroller: fechacontroller, // Pasa el controlador de fecha.
      horacontroller: horacontroller, // Pasa el controlador de hora.
      ipcontroller: ipcontroller, // Pasa el controlador de IP.
      bssidcontroller: bssidcontroller, // Pasa el controlador de BSSID.
      uuidcontroller: uuicontroller, // Pasa el controlador de UUID.
      idusuariocontroller: idusuariocontroller, // Pasa el controlador de ID de usuario.
      nombreusuariocontroller: nombreusuariocontroller, // Pasa el controlador de nombre de usuario.
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
    // Permission.locationWhenInUse.request() muestra un diálogo al usuario solicitando permiso para acceder a la ubicación.
    await Permission.locationWhenInUse.request();
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
      // Define la barra de la aplicación con un título centrado "ENTRADA".
      appBar: AppBar(
        // Establece el título de la barra de la aplicación con estilo en negrita y tamaño 24.
        title: const Text('ENTRADA',
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
            // Añade campos de entrada para ID de usuario, usuario, fecha de entrada, hora de entrada, IP de entrada, BSSID de entrada y UUID de entrada.
            // Cada campo de entrada se crea llamando al método `_campoEntrada` con una etiqueta y un controlador.
            _campoEntrada("ID USUARIO:", idusuariocontroller),
            _campoEntrada("USUARIO:", nombreusuariocontroller),
            _campoEntrada("FECHA ENTRADA:", fechacontroller),
            _campoEntrada("HORA ENTRADA:", horacontroller),
            _campoEntrada("IP ENTRADA:", ipcontroller),
            _campoEntrada("BSSID ENTRADA:", bssidcontroller),
            _campoEntrada("UUID ENTRADA:", uuicontroller),
            // Añade un espacio de 30 píxeles de altura.
            const SizedBox(height: 30),
            // Centra los botones de registrar entrada y regresar.
            Center(
              child: Column(
                children: [
                  // Añade un botón de éxito para registrar la entrada.
                  // 'Estilosbotones.btnsuccess' es un método personalizado que crea un botón con estilo de éxito.
                  Estilosbotones.btnsuccess("REGISTRAR ENTRADA", () async {
                    // Registra la entrada y obtiene el resultado.
                    // 'await' espera a que la operación asíncrona se complete antes de continuar.
                    // La función 'registrar' es una operación asíncrona que registra la entrada del usuario.
                    Object? resultado = await registrar(
                      context, // Contexto de la aplicación, necesario para mostrar diálogos o navegar.
                      fechacontroller, // Controlador de fecha, contiene la fecha de entrada.
                      horacontroller, // Controlador de hora, contiene la hora de entrada.
                      ipcontroller, // Controlador de IP, contiene la IP de entrada.
                      bssidcontroller, // Controlador de BSSID, contiene el BSSID de entrada.
                      uuicontroller, // Controlador de UUID, contiene el UUID de entrada.
                      widget.nombreusuario, // Nombre de usuario, pasado al widget.
                    );

                    // Si el resultado no es nulo y es un entero, guarda el ID de asistencia en las preferencias compartidas.
                    if (resultado != null && resultado is int) {
                      // Obtiene una instancia de SharedPreferences.
                      // SharedPreferences es un almacenamiento simple de clave-valor persistente.
                      final prefs = await SharedPreferences.getInstance();
                      // Guarda el ID de asistencia en las preferencias compartidas.
                      // 'setInt' guarda un valor entero asociado con una clave.
                      await prefs.setInt('idasistencia', resultado);
                      // Imprime el ID de asistencia generado en la consola para depuración.
                      print('ID asistencia generado: $resultado');
                    }
                  }),
                  // Añade un espacio de 15 píxeles de altura.
                  const SizedBox(height: 15),
                  // Añade un botón de peligro para regresar a la vista de escritorio.
                  // 'Estilosbotones.btndanger' es un método personalizado que crea un botón con estilo de peligro.
                  Estilosbotones.btndanger("REGRESAR", () {
                    // Navega a la vista de escritorio, reemplazando la vista actual.
                    // 'Navigator.pushReplacement' reemplaza la ruta actual en el stack de navegación.
                    // Esto significa que el usuario no podrá volver a esta vista usando el botón de retroceso.
                    Navigator.pushReplacement(
                      context, // Contexto de la aplicación, necesario para la navegación.
                      MaterialPageRoute(
                        builder: (context) =>
                            escritorio(nombreusuario: widget.nombreusuario), // Ruta a la vista de escritorio.
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      // Añade un pie de página al final de la vista.
      // 'Piedepagina' es un widget personalizado que muestra el pie de página.
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
          Text(etiqueta, style: const TextStyle(fontWeight: FontWeight.bold)), // Establece el estilo de texto en negrita.
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
}
