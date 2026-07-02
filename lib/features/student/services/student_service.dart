import '../data/models/student_model.dart';
import '../data/repositories/student_repository.dart';

enum SortBy { name, age, major, date }
enum SortOrder { ascending, descending }

class StudentService {
  final StudentRepository _repository;

  StudentService({StudentRepository? repository})
      : _repository = repository ?? StudentRepository();

  Future<List<StudentModel>> loadStudents() async {
    return await _repository.getAllStudents();
  }

  Future<List<StudentModel>> searchStudents(String query) async {
    if (query.trim().isEmpty) {
      return await _repository.getAllStudents();
    }
    return await _repository.searchStudents(query.trim());
  }

  Future<List<StudentModel>> loadSortedStudents({
    required SortBy sortBy,
    SortOrder order = SortOrder.descending,
  }) async {
    final students = await _repository.getAllStudents();
    return sortStudents(students, sortBy, order);
  }

  Future<List<StudentModel>> searchAndSortStudents({
    required String query,
    required SortBy sortBy,
    SortOrder order = SortOrder.descending,
  }) async {
    final students = await searchStudents(query);
    return sortStudents(students, sortBy, order);
  }

  List<StudentModel> sortStudents(
    List<StudentModel> students,
    SortBy sortBy,
    SortOrder order,
  ) {
    var sorted = List<StudentModel>.from(students);

    switch (sortBy) {
      case SortBy.name:
        sorted.sort((a, b) => a.name.compareTo(b.name));
      case SortBy.age:
        sorted.sort((a, b) => a.age.compareTo(b.age));
      case SortBy.major:
        sorted.sort((a, b) => a.major.compareTo(b.major));
      case SortBy.date:
        sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    if (order == SortOrder.descending) {
      sorted = sorted.reversed.toList();
    }

    return sorted;
  }

  Future<StudentModel?> getStudentById(int id) async {
    return await _repository.getStudentById(id);
  }

  Future<StudentModel?> getStudentByQrCode(String qrCode) async {
    return await _repository.getStudentByQrCode(qrCode);
  }

  Future<int> addStudent(StudentModel student) async {
    return await _repository.addStudent(student);
  }

  Future<int> updateStudent(StudentModel student) async {
    return await _repository.updateStudent(student);
  }

  Future<int> deleteStudent(int id) async {
    return await _repository.deleteStudent(id);
  }

  Future<int> getStudentCount() async {
    return await _repository.getStudentCount();
  }
}