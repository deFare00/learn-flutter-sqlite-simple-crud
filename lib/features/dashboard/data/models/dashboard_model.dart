import '../../../student/data/models/student_model.dart';

class DashboardModel {
  final int totalStudents;
  final List<StudentModel> recentStudents;
  final Map<String, int> majorStatistics;

  const DashboardModel({
    required this.totalStudents,
    required this.recentStudents,
    required this.majorStatistics,
  });

  /// Get the most common major
  String? getMostCommonMajor() {
    if (majorStatistics.isEmpty) return null;
    return majorStatistics.entries.reduce((a, b) =>
        a.value > b.value ? a : b).key;
  }

  /// Get the count of the most common major
  int getMostCommonMajorCount() {
    if (majorStatistics.isEmpty) return 0;
    return majorStatistics.entries.reduce((a, b) =>
        a.value > b.value ? a : b).value;
  }
}