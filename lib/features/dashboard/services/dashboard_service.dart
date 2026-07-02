import '../../student/services/student_service.dart';
import '../../student/data/models/student_model.dart';
import '../data/models/dashboard_model.dart';

class DashboardService {
  final StudentService _studentService;

  DashboardService({StudentService? studentService})
      : _studentService = studentService ?? StudentService();

  /// Get dashboard statistics
  Future<DashboardModel> getDashboardData() async {
    final students = await _studentService.loadStudents();
    return DashboardModel(
      totalStudents: students.length,
      recentStudents: students.take(5).toList(),
      majorStatistics: _calculateMajorStatistics(students),
    );
  }

  /// Get total student count
  Future<int> getTotalStudents() async {
    return await _studentService.getStudentCount();
  }

  /// Get recent students (max 5)
  Future<List<StudentModel>> getRecentStudents({int limit = 5}) async {
    final students = await _studentService.loadStudents();
    return students.take(limit).toList();
  }

  /// Calculate statistics by major
  Map<String, int> _calculateMajorStatistics(List<StudentModel> students) {
    final Map<String, int> stats = {};
    for (final student in students) {
      stats[student.major] = (stats[student.major] ?? 0) + 1;
    }
    return stats;
  }
}