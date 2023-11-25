import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu contraseña';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: Text('Iniciar sesión'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    final userCredential = await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    // Si el inicio de sesión es exitoso, navega a la pantalla principal
                    if (userCredential.user != null) {
                      Navigator.pushNamed(context, '/home');
                    }
                  } on FirebaseAuthException catch (e) {
                    // Maneja los errores de inicio de sesión
                    print(e.message);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}