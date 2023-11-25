import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido a nuestra aplicación',
            ),
            ElevatedButton(
              child: Text('Registrarse'),
              onPressed: () {
                // Navega a la pantalla de registro
                Navigator.pushNamed(context, '/register');
              },
            ),
            ElevatedButton(
              child: Text('Iniciar sesión'),
              onPressed: () {
                // Navega a la pantalla de inicio de sesión
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}