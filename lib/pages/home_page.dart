import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/student.dart';
import '../widgets/student_card.dart';
import 'add_student_page.dart';
import 'edit_student_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Student>> students;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  void loadStudents() {
    students = DatabaseHelper.instance.getStudents();
  }

  Future<void> _navigateToAddStudent() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddStudentPage()),
    );

    setState(() {
      loadStudents();
    });
  }

  Future<void> _navigateToEditStudent(Student student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditStudentPage(student: student)),
    );

    setState(() {
      loadStudents();
    });
  }

  Future<void> _deleteStudent(Student student) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Student"),
          content: Text("Are you sure you want to delete ${student.name}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await DatabaseHelper.instance.deleteStudent(student.id!);

    if (!mounted) return;

    setState(() {
      loadStudents();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${student.name} deleted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // Empty Data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No Student Found", style: TextStyle(fontSize: 18)),
            );
          }

          final studentList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];

              return StudentCard(
                student: student,

                // Edit Student
                onTap: () {
                  _navigateToEditStudent(student);
                },

                // Delete Student
                onDelete: () {
                  _deleteStudent(student);
                },
              );
            },
          );
        },
      ),

      // Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
