// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
import 'package:flutter/material.dart';

// Define una clase `Estilosbotones` que contiene métodos estáticos para crear botones con diferentes estilos.
// Esta clase proporciona una forma consistente de crear botones en toda la aplicación.
class Estilosbotones {
  // Método estático para crear un botón con estilo predeterminado.
  // Este método devuelve un widget Column que contiene un TextButton con estilo predeterminado.
  // 'static' indica que este método pertenece a la clase y no a una instancia específica.
  static Widget btndefault(String text, VoidCallback onPressed) {
    // Devuelve un widget Column que organiza sus hijos verticalmente.
    return Column(
      children: [
        // TextButton es un botón de texto plano sin relleno.
        TextButton(
          onPressed: onPressed, // Función que se ejecuta cuando se presiona el botón.
          child: Text(text), // Texto del botón.
        ),
        // SizedBox añade un espacio vertical de 20 píxeles.
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón primario (azul).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo primario.
  static Widget btnprimary(String text, VoidCallback onPressed) {
    return Column(
      children: [
        // ElevatedButton es un botón con relleno y elevación.
        ElevatedButton(
          // Estilo del botón.
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Color de fondo azul.
            foregroundColor: Colors.white, // Color del texto blanco.
          ),
          onPressed: onPressed, // Función que se ejecuta cuando se presiona el botón.
          child: Text(text), // Texto del botón.
        ),
        const SizedBox(height: 20), // Espacio vertical de 20 píxeles.
      ],
    );
  }

  // Método estático para crear un botón secundario (gris).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo secundario.
  static Widget btnsecondary(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey, // Color de fondo gris.
            foregroundColor: Colors.white, // Color del texto blanco.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón de éxito (verde).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo de éxito.
  static Widget btnsuccess(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Color de fondo verde.
            foregroundColor: Colors.white, // Color del texto blanco.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón de información (azul claro).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo de información.
  static Widget btninfo(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue, // Color de fondo azul claro.
            foregroundColor: Colors.white, // Color del texto blanco.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón de peligro (rojo).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo de peligro.
  static Widget btndanger(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Color de fondo rojo.
            foregroundColor: Colors.white, // Color del texto blanco.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón de advertencia (amarillo).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo de advertencia.
  static Widget btnwarning(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700], // Color de fondo amarillo oscuro.
            foregroundColor: Colors.black, // Color del texto negro.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón claro (blanco con borde gris).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo claro.
  static Widget btnlight(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Color de fondo blanco.
            foregroundColor: Colors.black, // Color del texto negro.
            side: const BorderSide(color: Colors.grey), // Borde gris.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Método estático para crear un botón oscuro (negro con texto blanco).
  // Este método devuelve un widget Column que contiene un ElevatedButton con estilo oscuro.
  static Widget btndark(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Color de fondo negro.
            foregroundColor: Colors.white, // Color del texto blanco.
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
