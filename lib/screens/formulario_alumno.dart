import 'package:flutter/material.dart';
import '../models/alumno.dart';
import '../services/db_service.dart';

class FormularioAlumno extends StatefulWidget {
  final Alumno? alumno;

  const FormularioAlumno({super.key, this.alumno});

  @override
  State<FormularioAlumno> createState() => _FormularioAlumnoState();
}

class _FormularioAlumnoState extends State<FormularioAlumno> {
  final _formKey = GlobalKey<FormState>();
  final db = DBService();

  final TextEditingController _rudeCtrl = TextEditingController();
  final TextEditingController _ciCtrl = TextEditingController();
  final TextEditingController _complementoCtrl = TextEditingController();
  final TextEditingController _fechaNacimientoCtrl = TextEditingController();
  final TextEditingController _cursoCtrl = TextEditingController();
  final TextEditingController _codSieUeCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.alumno != null) {
      _rudeCtrl.text = widget.alumno!.rude;
      _ciCtrl.text = widget.alumno!.ci;
      _complementoCtrl.text = widget.alumno!.complemento;
      _fechaNacimientoCtrl.text = widget.alumno!.fechaNacimiento;
      _cursoCtrl.text = widget.alumno!.curso;
      _codSieUeCtrl.text = widget.alumno!.codSieUe;
    }
  }

  Future<void> guardarAlumno() async {
    if (_formKey.currentState!.validate()) {
      final nuevoAlumno = Alumno(
        id: widget.alumno?.id,
        rude: _rudeCtrl.text,
        ci: _ciCtrl.text,
        complemento: _complementoCtrl.text,
        fechaNacimiento: _fechaNacimientoCtrl.text,
        curso: _cursoCtrl.text,
        codSieUe: _codSieUeCtrl.text,
        fechaReg: DateTime.now().toIso8601String(),
      );

      if (widget.alumno == null) {
        await db.insertAlumno(nuevoAlumno);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alumno añadido exitosamente')),
        );
      } else {
        await db.updateAlumno(nuevoAlumno);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Alumno actualizado exitosamente')),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alumno == null ? 'Añadir Alumno' : 'Editar Alumno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _rudeCtrl,
                decoration: const InputDecoration(labelText: 'RUDE'),
                validator: (value) =>
                    value!.isEmpty ? 'Este campo es obligatorio' : null,
              ),
              TextFormField(
                controller: _ciCtrl,
                decoration: const InputDecoration(labelText: 'CI'),
              ),
              TextFormField(
                controller: _complementoCtrl,
                decoration: const InputDecoration(labelText: 'Complemento'),
              ),
              TextFormField(
                controller: _fechaNacimientoCtrl,
                decoration: const InputDecoration(labelText: 'Fecha de Nacimiento'),
              ),
              TextFormField(
                controller: _cursoCtrl,
                decoration: const InputDecoration(labelText: 'Curso'),
              ),
              TextFormField(
                controller: _codSieUeCtrl,
                decoration: const InputDecoration(labelText: 'Código SIE UE'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: guardarAlumno,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
