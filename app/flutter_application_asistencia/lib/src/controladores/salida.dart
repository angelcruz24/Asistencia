// lib/controllers/salida_controller.dart
import 'package:flutter/material.dart';

class SalidaController {
  final TextEditingController usuarioController = TextEditingController(text: "Juan Pérez");
  final TextEditingController fechaSalidaController = TextEditingController(text: "2025-05-13");
  final TextEditingController horaSalidaController = TextEditingController(text: "18:00");
  final TextEditingController ipSalidaController = TextEditingController(text: "192.168.1.10");
  final TextEditingController macSalidaController = TextEditingController(text: "00:1A:2B:3C:4D:5E");
  final TextEditingController actividadesController = TextEditingController();

  void registrarSalida() {
    // Aquí puedes poner la lógica de registrar salida
    debugPrint("Salida registrada:");
    debugPrint("Usuario: ${usuarioController.text}");
    debugPrint("Fecha: ${fechaSalidaController.text}");
    debugPrint("Hora: ${horaSalidaController.text}");
    debugPrint("IP: ${ipSalidaController.text}");
    debugPrint("MAC: ${macSalidaController.text}");
    debugPrint("Actividades: ${actividadesController.text}");
  }

  void dispose() {
    usuarioController.dispose();
    fechaSalidaController.dispose();
    horaSalidaController.dispose();
    ipSalidaController.dispose();
    macSalidaController.dispose();
    actividadesController.dispose();
  }
}