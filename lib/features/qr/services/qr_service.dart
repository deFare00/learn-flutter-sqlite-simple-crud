import '../../student/data/models/student_model.dart';
import '../../student/services/student_service.dart';

class QrService {
  final StudentService _studentService;

  QrService({StudentService? studentService})
      : _studentService = studentService ?? StudentService();

  /// Generate a unique QR code string for a new student
  String generateQrCode() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = (timestamp % 100000).toString().padLeft(5, '0');
    return 'STD_$randomSuffix';
  }

  /// Look up a student by their QR code string
  Future<StudentModel?> findStudentByQrCode(String qrCode) async {
    return await _studentService.getStudentByQrCode(qrCode);
  }

  /// Validate a QR code string format
  bool isValidQrCode(String code) {
    return code.startsWith('STD_') && code.length > 4;
  }
}