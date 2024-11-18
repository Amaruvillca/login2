import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/alumno.dart';

class DBService {
  static final DBService _instance = DBService._();
  static Database? _database;

  DBService._();

  factory DBService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'alumnos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE alumnos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        rude TEXT,
        ci TEXT,
        complemento TEXT,
        fechaNacimiento TEXT,
        curso TEXT,
        codSieUe TEXT,
        fechaReg TEXT
      )
    ''');
for (var i = 0; i < 15; i++) {
  await db.insert('alumnos', {
      'rude': 'RUDE00$i',
      'ci': '123456$i',
      'complemento': '',
      'fechaNacimiento': '2000-01-$i',
      'curso': '$i er Año',
      'codSieUe': 'SIE00$i',
      'fechaReg': DateTime.now().toIso8601String(),
    });
}
 
  }

  Future<List<Alumno>> getAlumnos() async {
    final db = await database;
    final result = await db.query('alumnos');
    return result.map((map) => Alumno.fromMap(map)).toList();
  }

  Future<int> insertAlumno(Alumno alumno) async {
    final db = await database;
    return await db.insert('alumnos', alumno.toMap());
  }

  Future<int> updateAlumno(Alumno alumno) async {
    final db = await database;
    return await db.update(
      'alumnos',
      alumno.toMap(),
      where: 'id = ?',
      whereArgs: [alumno.id],
    );
  }

  Future<int> deleteAlumno(int id) async {
    final db = await database;
    return await db.delete('alumnos', where: 'id = ?', whereArgs: [id]);
  }

Future<String?> validarLogin(String identificador, String fechaNacimiento) async {
  final db = await database;

  // Buscar si el identificador (rude o ci) existe
  final identificadorResultado = await db.query(
    'alumnos',
    where: '(rude = ? OR ci = ?)',
    whereArgs: [identificador, identificador],
    limit: 1,
  );

  if (identificadorResultado.isEmpty) {
    return 'Alumno no encontrado'; 
  }

  // Verificar si la fecha de nacimiento coincide
  final resultadoCompleto = await db.query(
    'alumnos',
    where: '(rude = ? OR ci = ?) AND fechaNacimiento = ?',
    whereArgs: [identificador, identificador, fechaNacimiento],
    limit: 1,
  );

  if (resultadoCompleto.isEmpty) {
    return 'Fecha de nacimiento incorrecta'; 
  }

  return null; 
}


}
