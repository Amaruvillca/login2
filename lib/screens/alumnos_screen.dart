import 'package:flutter/material.dart';
import 'package:login2/screens/formulario_alumno.dart';
import '../models/alumno.dart';
import '../services/db_service.dart';

class PantallaAlumnos extends StatefulWidget {
  const PantallaAlumnos({Key? key}) : super(key: key);

  @override
  State<PantallaAlumnos> createState() => _PantallaAlumnosState();
}

class _PantallaAlumnosState extends State<PantallaAlumnos> {
  List<Alumno> listaAlumnos = [];
  final db = DBService();

  @override
  void initState() {
    super.initState();
    cargarAlumnos();
  }

  Future<void> cargarAlumnos() async {
    final alumnos = await db.getAlumnos();
    setState(() {
      listaAlumnos = alumnos;
    });
  }

  void navegarAFormulario({Alumno? alumno}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioAlumno(alumno: alumno),
      ),
    );
    cargarAlumnos();
  }

  void eliminarAlumno(int id) async {
    await db.deleteAlumno(id);
    cargarAlumnos();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alumno eliminado correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alumnos'),
      ),
      body: listaAlumnos.isEmpty
          ? const Center(child: Text('No hay alumnos registrados.'))
          : ListView.builder(
              itemCount: listaAlumnos.length,
              itemBuilder: (context, index) {
                final alumno = listaAlumnos[index];
                return Card(
                  child: ListTile(
                    title: Text(alumno.rude),
                    subtitle: Text('CI: ${alumno.ci}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => navegarAFormulario(alumno: alumno),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => eliminarAlumno(alumno.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navegarAFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}