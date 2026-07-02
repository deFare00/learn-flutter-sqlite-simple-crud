import 'package:flutter/material.dart';

import '../../services/dashboard_service.dart';
import '../widgets/dashboard_cards.dart';
import '../../../student/data/models/student_model.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardService _dashboardService = DashboardService();

  bool _isLoading = true;
  int _totalStudents = 0;
  List<StudentModel> _recentStudents = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      final total = await _dashboardService.getTotalStudents();
      final recent = await _dashboardService.getRecentStudents();

      if (!mounted) return;

      setState(() {
        _totalStudents = total;
        _recentStudents = recent;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashboard),
        actions: [
          IconButton(
            onPressed: _loadDashboardData,
            icon: const Icon(Icons.refresh),
            tooltip: AppStrings.retry,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.addStudent),
        tooltip: AppStrings.addStudent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget();
    }

    if (_error != null) {
      return EmptyState(
        icon: Icons.error_outline,
        title: AppStrings.errorOccurred,
        subtitle: _error,
        actionLabel: AppStrings.retry,
        onAction: _loadDashboardData,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: ListView(
        padding: const EdgeInsets.all(AppSizes.md),
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: AppSizes.md),
          _buildStatisticsSection(),
          const SizedBox(height: AppSizes.lg),
          _buildQuickActionsSection(),
          const SizedBox(height: AppSizes.lg),
          _buildRecentStudentsSection(),
          const SizedBox(height: AppSizes.xxl),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Card(
      elevation: AppSizes.cardElevation,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSizes.sm),
            Text(
              AppStrings.appTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return TotalCard(
      count: _totalStudents,
      label: AppStrings.totalStudents,
      icon: Icons.people_outline,
      color: AppColors.primary,
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
          child: Text(
            AppStrings.quickActions,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: AppStrings.scanQR,
                subtitle: 'Scan student QR',
                icon: Icons.qr_code_scanner,
                color: AppColors.primary,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.qrScanner),
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: QuickActionCard(
                title: AppStrings.addStudent,
                subtitle: 'Add new student',
                icon: Icons.person_add,
                color: AppColors.success,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.addStudent),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentStudentsSection() {
    if (_recentStudents.isEmpty) {
      return EmptyState(
        icon: Icons.person_outline,
        title: AppStrings.noStudents,
        subtitle: 'No students added yet',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.recentStudents,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.studentList),
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.md),
        ..._recentStudents.map((student) => RecentStudentCard(
              name: student.name,
              major: student.major,
              initials: student.initials,
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.studentDetail,
                arguments: student,
              ),
            )),
      ],
    );
  }
}