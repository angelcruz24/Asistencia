import 'package:flutter/material.dart';

class Estilosbotones {
  // Botón normal
  static Widget btndefault(String text, VoidCallback onPressed) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 1
  static Widget btnprimary(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 2
  static Widget btnsecondary(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 3
  static Widget btnsuccess(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 4
  static Widget btninfo(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 5
  static Widget btndanger(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 6
  static Widget btnwarning(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            foregroundColor: Colors.black,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 7
  static Widget btnlight(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.grey),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Botón 8
  static Widget btndark(String text, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
