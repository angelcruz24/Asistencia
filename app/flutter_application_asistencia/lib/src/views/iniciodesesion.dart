import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario:',
                ),
              ),
            ),

            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña:',
                ),
              ),
            ),

            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {},
              child: Text('Ingresar'),
            ),

            Spacer(),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text('Copyright © 2025 | Versión 1.9.9.2 - 8/5/2025'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}