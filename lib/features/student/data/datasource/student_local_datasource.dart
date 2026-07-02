import '../../../../core/services/database_service.dart';
import '../models/student_model.dart';

class StudentLocalDatasource {
  final DatabaseService _databaseService;

  StudentLocalDatasource({DatabaseService? databaseService})
      : _databaseService = databaseService ?? DatabaseService.instance;

  Future<int> insertStudent(StudentModel student) async {
    return await _databaseService.insertStudent(student);
  }

  Future<List<StudentModel>> getStudents() async {
    return await _databaseService.getStudents();
  }

  Future<StudentModel?> getStudentById(int id) async {
    return await _databaseService.getStudentById(id);
  }

  Future<StudentModel?> getStudentByQrCode(String qrCode) async {
    return await _databaseService.getStudentByQrCode(qrCode);
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    return await _databaseService.searchStudents(query);
  }

  Future<int> updateStudent(StudentModel student) async {
    return await _databaseService.updateStudent(student);
  }

  Future<int> deleteStudent(int id) async {
    return await _databaseService.deleteStudent(id);
  }

  Future<int> getStudentCount() async {
    return await _databaseService.getStudentCount();
  }
}