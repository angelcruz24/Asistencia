// lib/controllers/salida_controller.dart
import 'package:flutter/material.dart';

class salidacontroller {
  final TextEditingController usuariocontroller = TextEditingController();
  final TextEditingController fechasalidacontroller = TextEditingController();
  final TextEditingController horasalidacontroller = TextEditingController();
  final TextEditingController ipsalidacontroller = TextEditingController();
  final TextEditingController bssidsalidadcontroller = TextEditingController();
  final TextEditingController uuisalidacontroller = TextEditingController();
  final TextEditingController actividadescontroller = TextEditingController();

  void registrarSalida() {
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
