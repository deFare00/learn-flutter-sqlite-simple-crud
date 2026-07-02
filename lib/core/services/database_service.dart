import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/student/data/models/student_model.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'student.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        major TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        qr_code TEXT UNIQUE,
        latitude REAL,
        longitude REAL,
        address TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');
  }

  // ==================== Student CRUD ====================

  Future<int> insertStudent(StudentModel student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  Future<List<StudentModel>> getStudents() async {
    final db = await database;
    final maps = await db.query(
      'students',
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => StudentModel.fromMap(map)).toList();
  }

  Future<StudentModel?> getStudentById(int id) async {
    final db = await database;
    final maps = await db.query(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return StudentModel.fromMap(maps.first);
  }

  Future<StudentModel?> getStudentByQrCode(String qrCode) async {
    final db = await database;
    final maps = await db.query(
      'students',
      where: 'qr_code = ?',
      whereArgs: [qrCode],
    );
    if (maps.isEmpty) return null;
    return StudentModel.fromMap(maps.first);
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    final db = await database;
    final maps = await db.query(
      'students',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'created_at DESC',
    );
    return maps.map((map) => StudentModel.fromMap(map)).toList();
  }

  Future<int> updateStudent(StudentModel student) async {
    final db = await database;
    return await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getStudentCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM students',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}