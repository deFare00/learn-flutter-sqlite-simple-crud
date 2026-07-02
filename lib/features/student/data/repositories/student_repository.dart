import '../datasource/student_local_datasource.dart';
import '../models/student_model.dart';

class StudentRepository {
  final StudentLocalDatasource _datasource;

  StudentRepository({StudentLocalDatasource? datasource})
      : _datasource = datasource ?? StudentLocalDatasource();

  Future<int> addStudent(StudentModel student) async {
    return await _datasource.insertStudent(student);
  }

  Future<List<StudentModel>> getAllStudents() async {
    return await _datasource.getStudents();
  }

  Future<StudentModel?> getStudentById(int id) async {
    return await _datasource.getStudentById(id);
  }

  Future<StudentModel?> getStudentByQrCode(String qrCode) async {
    return await _datasource.getStudentByQrCode(qrCode);
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    return await _datasource.searchStudents(query);
  }

  Future<int> updateStudent(StudentModel student) async {
    return await _datasource.updateStudent(student);
  }

  Future<int> deleteStudent(int id) async {
    return await _datasource.deleteStudent(id);
  }

  Future<int> getStudentCount() async {
    return await _datasource.getStudentCount();
  }
}