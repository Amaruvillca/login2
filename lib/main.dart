import 'package:flutter/material.dart';
import 'package:login2/login_screen.dart';

import 'screens/alumnos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Alumnos',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/alumnos': (context) => const PantallaAlumnos(),
      },
    );
  }
}
