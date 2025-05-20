// Importa el paquete principal de Flutter para el desarrollo de interfaces de usuario.
// Material.dart proporciona widgets y herramientas esenciales para construir interfaces en Flutter.
// Incluye widgets como Padding, Text, EdgeInsets, TextAlign, etc.
import 'package:flutter/material.dart';

// Define una clase `Piedepagina` que extiende `StatelessWidget`.
// StatelessWidget es un widget que no tiene estado mutable y se construye una sola vez con los parámetros proporcionados.
// Es ideal para componentes de la interfaz que no necesitan cambiar su estado internamente.
class Piedepagina extends StatelessWidget {
  // Constructor de la clase `Piedepagina` que acepta una clave opcional.
  // La palabra clave 'super.key' pasa la clave al constructor de la clase padre (StatelessWidget).
  // 'const' indica que este constructor crea una instancia constante del widget.
  const Piedepagina({super.key});

  // Sobrescribe el método `build` para construir la interfaz de usuario del widget.
  // Este método se llama cada vez que el widget necesita ser renderizado.
  // Es el método principal para definir la interfaz de usuario de un widget.
  @override
  Widget build(BuildContext context) {
    // Devuelve un widget `Padding` que añade espacio alrededor de su hijo.
    // Padding es un widget que añade espacio alrededor de su contenido.
    return const Padding(
      // Establece un padding de 8 píxeles en todos los lados (arriba, abajo, izquierda, derecha).
      padding: EdgeInsets.all(8),
      // Text es un widget que muestra una cadena de texto con un estilo.
      child: Text(
        // Texto a mostrar en el pie de página.
        // Contiene información de copyright, versión y fecha.
        "Copyright © 2025 SEISMEXICO | Versión 0.1.63 | 14 Mayo 2025",
        // Alinea el texto al centro horizontalmente.
        textAlign: TextAlign.center,
      ),
    );
  }
}
