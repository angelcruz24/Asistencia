// lib/controllers/salida_controller.dart
import 'package:flutter/material.dart';

class salidacontroller {
  final TextEditingController usuariocontroller = TextEditingController(text: "Juan Pérez");
  final TextEditingController fechasalidacontroller = TextEditingController(text: "2025-05-13");
  final TextEditingController horasalidacontroller = TextEditingController(text: "18:00");
  final TextEditingController ipsalidacontroller = TextEditingController(text: "192.168.1.10");
  final TextEditingController macsalidacontroller = TextEditingController(text: "00:1A:2B:3C:4D:5E");
  final TextEditingController actividadescontroller = TextEditingController();

  void registrarSalida() {
    // Aquí puedes poner la lógica de registrar salida
    debugPrint("Salida registrada:");
    debugPrint("Usuario: ${usuariocontroller.text}");
    debugPrint("Fecha: ${fechasalidacontroller.text}");
    debugPrint("Hora: ${horasalidacontroller.text}");
    debugPrint("IP: ${ipsalidacontroller.text}");
    debugPrint("MAC: ${macsalidacontroller.text}");
    debugPrint("Actividades: ${actividadescontroller.text}");
  }

  void dispose() {
    usuariocontroller.dispose();
    fechasalidacontroller.dispose();
    horasalidacontroller.dispose();
    ipsalidacontroller.dispose();
    macsalidacontroller.dispose();
    actividadescontroller.dispose();
  }
}