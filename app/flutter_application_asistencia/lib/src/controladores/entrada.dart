// lib/controllers/salida_controller.dart
import 'package:flutter/material.dart';

class entradacontroller {
  final TextEditingController usuariocontroller = TextEditingController(text: "Juan Pérez");
  final TextEditingController fechasalidacontroller = TextEditingController(text: "2025-05-13");
  final TextEditingController horasalidacontroller = TextEditingController(text: "18:00");
  final TextEditingController ipsalidacontroller = TextEditingController(text: "192.168.1.10");
  final TextEditingController bssidsalidadcontroller = TextEditingController(text: "00:1A:2B:3C:4D:5E");
  final TextEditingController uuisalidacontroller = TextEditingController(text: "00:1A:2B:3C:4D:5E");
  final TextEditingController actividadescontroller = TextEditingController();

  void registrarentrada() {
    // Aquí puedes poner la lógica de registrar salida
    debugPrint("Salida registrada:");
    debugPrint("Usuario: ${usuariocontroller.text}");
    debugPrint("Fecha: ${fechasalidacontroller.text}");
    debugPrint("Hora: ${horasalidacontroller.text}");
    debugPrint("IP: ${ipsalidacontroller.text}");
    debugPrint("BSSID: ${bssidsalidadcontroller.text}");
    debugPrint("UUI: ${uuisalidacontroller.text}");
    debugPrint("Actividades: ${actividadescontroller.text}");
  }

  void dispose() {
    usuariocontroller.dispose();
    fechasalidacontroller.dispose();
    horasalidacontroller.dispose();
    ipsalidacontroller.dispose();
    bssidsalidadcontroller.dispose();
    uuisalidacontroller.dispose();
    actividadescontroller.dispose();
  }
}
