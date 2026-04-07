import 'package:flutter/material.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:attendance_app/services/auth_service.dart';
import 'package:attendance_app/models/attendance_record.dart';
import 'package:attendance_app/themes/app_theme.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  final _attendanceService = AttendanceService();
  final _authService = AuthService();
  late String _studentId;
  late Future<List<AttendanceRecord>> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    final user = _authService.getCurrentUser();
    _studentId = user?.uid ?? '';
    _attendanceFuture = _attendanceService.getStudentAttendance(_studentId);
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
        title: const Text('Attendance History', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.secondary.withOpacity(0.08),
              AppColors.primary.withOpacity(0.08),
            ],
          ),
        ),
        child: FutureBuilder<List<AttendanceRecord>>(
          future: _attendanceFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final records = snapshot.data ?? [];

            if (records.isEmpty) {
              return const Center(
                child: Text('No attendance records yet'),
              );
            }

            final Map<String, List<AttendanceRecord>> groupedRecords = {};
            for (final record in records) {
              if (!groupedRecords.containsKey(record.subjectName)) {
                groupedRecords[record.subjectName] = [];
              }
              groupedRecords[record.subjectName]!.add(record);
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: groupedRecords.length,
              itemBuilder: (context, index) {
                final subjectName = groupedRecords.keys.elementAt(index);
                final subjectRecords = groupedRecords[subjectName]!;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: AppDecorations.cardDecoration(),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      title: Text(
                        subjectName,
                        style: AppTextStyles.bodyLarge,
                      ),
                      subtitle: Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Chip(
                          label: Text('${subjectRecords.length} attendance(s)'),
                          backgroundColor: AppColors.secondary.withOpacity(0.2),
                          labelStyle: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              ...subjectRecords.map((record) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: AppColors.secondary.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.check_circle,
                                              color: AppColors.secondary,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'Marked',
                                            style: TextStyle(
                                              color: AppColors.secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _formatDate(record.timestamp),
                                        style: AppTextStyles.caption,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} • ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
