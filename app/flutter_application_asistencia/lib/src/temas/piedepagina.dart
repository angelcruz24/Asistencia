import 'package:flutter/material.dart';

class Piedepagina extends StatelessWidget {
  const Piedepagina({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        "Copyright © 2025 SEISMEXICO | Versión 0.1.63 | 14 Mayo 2025",
        textAlign: TextAlign.center,
      ),
    );
  }
}
