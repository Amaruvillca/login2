class Alumno {
  final int? id;
  final String rude;
  final String ci;
  final String complemento;
  final String fechaNacimiento;
  final String curso;
  final String codSieUe;
  final String fechaReg;

  Alumno({
    this.id,
    required this.rude,
    required this.ci,
    required this.complemento,
    required this.fechaNacimiento,
    required this.curso,
    required this.codSieUe,
    required this.fechaReg,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rude': rude,
      'ci': ci,
      'complemento': complemento,
      'fechaNacimiento': fechaNacimiento,
      'curso': curso,
      'codSieUe': codSieUe,
      'fechaReg': fechaReg,
    };
  }

  factory Alumno.fromMap(Map<String, dynamic> map) {
    return Alumno(
      id: map['id'],
      rude: map['rude'],
      ci: map['ci'],
      complemento: map['complemento'],
      fechaNacimiento: map['fechaNacimiento'],
      curso: map['curso'],
      codSieUe: map['codSieUe'],
      fechaReg: map['fechaReg'],
    );
  }
}
