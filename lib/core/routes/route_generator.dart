import 'package:flutter/material.dart';

import 'app_routes.dart';
import '../../features/student/data/models/student_model.dart';
import '../../features/student/presentation/pages/student_list_page.dart';
import '../../features/student/presentation/pages/add_student_page.dart';
import '../../features/student/presentation/pages/student_detail_page.dart';
import '../../features/qr/presentation/pages/qr_scanner_page.dart';
import '../../features/qr/presentation/pages/qr_detail_page.dart';
import '../../features/maps/presentation/pages/pick_location_page.dart';
import '../../features/maps/presentation/pages/view_location_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        );

      case AppRoutes.studentList:
        return MaterialPageRoute(
          builder: (_) => const StudentListPage(),
        );

      case AppRoutes.addStudent:
        return MaterialPageRoute(
          builder: (_) => const AddStudentPage(),
        );

      case AppRoutes.editStudent:
        final student = settings.arguments as StudentModel;
        return MaterialPageRoute(
          builder: (_) => AddStudentPage(student: student),
        );

      case AppRoutes.studentDetail:
        final student = settings.arguments as StudentModel;
        return MaterialPageRoute(
          builder: (_) => StudentDetailPage(student: student),
        );

      case AppRoutes.qrScanner:
        return MaterialPageRoute(
          builder: (_) => const QrScannerPage(),
        );

      case AppRoutes.qrDetail:
        final student = settings.arguments as StudentModel;
        return MaterialPageRoute(
          builder: (_) => QrDetailPage(student: student),
        );

      case AppRoutes.pickLocation:
        final args = settings.arguments as Map<String, double>?;
        return MaterialPageRoute(
          builder: (_) => PickLocationPage(
            initialLatitude: args?['latitude'],
            initialLongitude: args?['longitude'],
          ),
        );

      case AppRoutes.maps:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ViewLocationPage(
            latitude: args['latitude'] as double,
            longitude: args['longitude'] as double,
            studentName: args['studentName'] as String?,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        );
    }
  }
}