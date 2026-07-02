import 'dart:async';

import 'package:flutter/material.dart';

import '../../services/student_service.dart';
import '../../data/models/student_model.dart';
import '../widgets/student_card.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/confirmation_dialog.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/extensions.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final StudentService _studentService = StudentService();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  List<StudentModel> _students = [];
  List<StudentModel> _displayedStudents = [];
  bool _isLoading = true;
  String? _errorMessage;

  SortBy _sortBy = SortBy.date;
  SortOrder _sortOrder = SortOrder.descending;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadStudents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final students = await _studentService.loadStudents();
      if (!mounted) return;
      setState(() {
        _students = students;
        _isLoading = false;
      });
      _applySortAndFilter();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _searchQuery = query;
      _applySortAndFilter();
    });
    setState(() {});
  }

  void _clearSearch() {
    _searchController.clear();
    _searchQuery = '';
    _debounceTimer?.cancel();
    _applySortAndFilter();
  }

  void _applySortAndFilter() {
    setState(() {
      if (_searchQuery.trim().isEmpty) {
        _displayedStudents =
            _studentService.sortStudents(_students, _sortBy, _sortOrder);
      } else {
        final filtered = _students
            .where((s) =>
                s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                s.major.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
        _displayedStudents =
            _studentService.sortStudents(filtered, _sortBy, _sortOrder);
      }
    });
  }

  void _setSortBy(SortBy sortBy) {
    if (_sortBy == sortBy) {
      _sortOrder = _sortOrder == SortOrder.ascending
          ? SortOrder.descending
          : SortOrder.ascending;
    } else {
      _sortBy = sortBy;
      _sortOrder = SortOrder.ascending;
    }
    _applySortAndFilter();
  }

  Future<void> _deleteStudent(StudentModel student) async {
    await ConfirmationDialog.show(
      context,
      title: AppStrings.deleteStudent,
      message: '${AppStrings.deleteConfirmation}\n\n${student.name}',
      onConfirm: () async {
        try {
          await _studentService.deleteStudent(student.id!);
          if (!mounted) return;
          context.showSuccessSnackBar(AppStrings.studentDeleted);
          _loadStudents();
        } catch (e) {
          if (!mounted) return;
          context.showErrorSnackBar(e.toString());
        }
      },
    );
  }

  void _navigateToAddStudent() {
    Navigator.of(context).pushNamed('/add-student').then((_) {
      _loadStudents();
    });
  }

  void _navigateToDetail(StudentModel student) {
    Navigator.of(context)
        .pushNamed('/student-detail', arguments: student)
        .then((_) {
      _loadStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStrings.studentList} (${_students.length})'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.qrScanner),
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: AppStrings.scanQR,
          ),
          IconButton(
            onPressed: _loadStudents,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildSortChips(),
          Expanded(child: _buildBody()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudent,
        tooltip: AppStrings.addStudent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.md,
        AppSizes.sm,
        AppSizes.md,
        0,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: AppStrings.search,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.clear),
                )
              : null,
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildSortChips() {
    final sortOptions = [
      (SortBy.name, Icons.sort_by_alpha, 'Name'),
      (SortBy.age, Icons.calendar_today, 'Age'),
      (SortBy.major, Icons.school, 'Major'),
      (SortBy.date, Icons.date_range, 'Date'),
    ];

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md - AppSizes.xs,
          vertical: AppSizes.sm,
        ),
        children: sortOptions.map((option) {
          final isActive = _sortBy == option.$1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    option.$2,
                    size: AppSizes.iconSmall,
                  ),
                  const SizedBox(width: AppSizes.xs),
                  Text(option.$3),
                  if (isActive) ...[
                    const SizedBox(width: AppSizes.xs),
                    Icon(
                      _sortOrder == SortOrder.ascending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 14,
                    ),
                  ],
                ],
              ),
              selected: isActive,
              onSelected: (_) => _setSortBy(option.$1),
              selectedColor: AppColors.primary.withValues(alpha: 0.15),
              checkmarkColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
              side: BorderSide(
                color: isActive ? AppColors.primary : AppColors.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusButton),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingWidget();
    }

    if (_errorMessage != null) {
      return EmptyState(
        icon: Icons.error_outline,
        title: AppStrings.errorOccurred,
        subtitle: _errorMessage,
        actionLabel: AppStrings.retry,
        onAction: _loadStudents,
      );
    }

    if (_students.isEmpty) {
      return EmptyState(
        icon: Icons.person_outline,
        title: AppStrings.noStudents,
        subtitle: 'Add a new student to get started',
        actionLabel: AppStrings.addStudent,
        onAction: _navigateToAddStudent,
      );
    }

    if (_displayedStudents.isEmpty) {
      return EmptyState(
        icon: Icons.search_off,
        title: 'No results found',
        subtitle: 'Try a different search term',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadStudents,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: AppSizes.xxl),
        itemCount: _displayedStudents.length,
        itemBuilder: (context, index) {
          final student = _displayedStudents[index];
          return StudentCard(
            student: student,
            onTap: () => _navigateToDetail(student),
            onDelete: () => _deleteStudent(student),
          );
        },
      ),
    );
  }
}

