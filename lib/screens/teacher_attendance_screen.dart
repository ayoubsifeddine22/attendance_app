import 'package:flutter/material.dart';
import 'package:attendance_app/services/subject_service.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:attendance_app/services/auth_service.dart';
import 'package:attendance_app/models/subject.dart';
import 'package:attendance_app/themes/app_theme.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  final _subjectService = SubjectService();
  final _attendanceService = AttendanceService();
  final _authService = AuthService();
  late String _teacherId;
  late Future<List<Subject>> _subjectsFuture;

  @override
  void initState() {
    super.initState();
    final user = _authService.getCurrentUser();
    _teacherId = user?.uid ?? '';
    _subjectsFuture = _subjectService.getTeacherSubjects(_teacherId);
  }

  Future<void> _viewAttendanceList(Subject subject) async {
    try {
      final attendanceList =
          await _attendanceService.getSubjectAttendanceList(subject.id);

      if (mounted) {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.accent, AppColors.warning],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${attendanceList.length} student(s) attended',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: attendanceList.isEmpty
                        ? const Center(
                            child: Text('No attendance records yet'),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: attendanceList.length,
                            itemBuilder: (context, index) {
                              final student = attendanceList[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                decoration: AppDecorations.cardDecoration(),
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [AppColors.primary, AppColors.accent],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.person, color: Colors.white),
                                  ),
                                  title: Text(student['email'], style: AppTextStyles.bodyLarge),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${student['attendanceCount']}x',
                                      style: const TextStyle(
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Attendance Records', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.warning.withOpacity(0.08),
              AppColors.accent.withOpacity(0.08),
            ],
          ),
        ),
        child: FutureBuilder<List<Subject>>(
          future: _subjectsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final subjects = snapshot.data ?? [];

            if (subjects.isEmpty) {
              return const Center(
                child: Text('No subjects yet'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return GestureDetector(
                  onTap: () => _viewAttendanceList(subject),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: AppDecorations.cardDecoration(),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.accent, AppColors.warning],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.book, color: Colors.white),
                      ),
                      title: Text(subject.name, style: AppTextStyles.bodyLarge),
                      subtitle: const Text('Tap to view attendance'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
