import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/models/attendance_record.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AttendanceRecord> recordAttendance(
    String studentId,
    String subjectId,
    String subjectName,
  ) async {
    try {
      final docRef = _firestore.collection('attendance').doc();
      final record = AttendanceRecord(
        id: docRef.id,
        studentId: studentId,
        subjectId: subjectId,
        subjectName: subjectName,
        timestamp: DateTime.now(),
      );

      await docRef.set(record.toMap());
      return record;
    } catch (e) {
      throw Exception('Failed to record attendance: $e');
    }
  }

  Future<bool> hasAttendanceToday(String studentId, String subjectId) async {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));

      final snapshot = await _firestore
          .collection('attendance')
          .where('studentId', isEqualTo: studentId)
          .where('subjectId', isEqualTo: subjectId)
          .where('timestamp', isGreaterThanOrEqualTo: today)
          .where('timestamp', isLessThan: tomorrow)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check attendance: $e');
    }
  }

  Future<List<AttendanceRecord>> getSubjectAttendance(String subjectId) async {
    try {
      final snapshot = await _firestore
          .collection('attendance')
          .where('subjectId', isEqualTo: subjectId)
          .get();

      final records = snapshot.docs
          .map((doc) => AttendanceRecord.fromMap(doc.data(), doc.id))
          .toList();
      

      records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return records;
    } catch (e) {
      throw Exception('Failed to fetch attendance records: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getSubjectAttendanceList(
      String subjectId) async {
    try {
      final snapshot = await _firestore
          .collection('attendance')
          .where('subjectId', isEqualTo: subjectId)
          .get();

      final studentIds =
          snapshot.docs.map((doc) => doc['studentId'] as String).toSet();

      final students = <Map<String, dynamic>>[];
      for (final studentId in studentIds) {
        final userDoc =
            await _firestore.collection('users').doc(studentId).get();
        if (userDoc.exists) {
          students.add({
            'id': studentId,
            'email': userDoc['email'],
            'attendanceCount': snapshot.docs
                .where((doc) => doc['studentId'] == studentId)
                .length,
          });
        }
      }

      return students;
    } catch (e) {
      throw Exception('Failed to fetch attendance list: $e');
    }
  }

  Future<List<AttendanceRecord>> getStudentAttendance(String studentId) async {
    try {
      final snapshot = await _firestore
          .collection('attendance')
          .where('studentId', isEqualTo: studentId)
          .get();

      final records = snapshot.docs
          .map((doc) => AttendanceRecord.fromMap(doc.data(), doc.id))
          .toList();
      

      records.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return records;
    } catch (e) {
      throw Exception('Failed to fetch student attendance: $e');
    }
  }
}
