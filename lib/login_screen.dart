import 'package:flutter/material.dart';
import 'package:login2/services/db_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
final db = DBService();
void _login() async {
  final db = DBService(); // Instancia del servicio de base de datos
  final identifier = _identifierController.text.trim();
  final birthDate = _birthDateController.text.trim();

  if (identifier.isEmpty || birthDate.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor completa todos los campos')),
    );
    return;
  }

  // Validar 
  final resultado = await db.validarLogin(identifier, birthDate);

  if (resultado == null) {
    Navigator.pushReplacementNamed(context, '/alumnos');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(resultado)),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _identifierController,
                decoration: const InputDecoration(labelText: 'RUDE o CI'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _birthDateController,
                decoration: const InputDecoration(labelText: 'Fecha de nacimiento'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}