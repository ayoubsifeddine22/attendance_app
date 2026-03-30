import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/models/subject.dart';

class SubjectService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new subject
  Future<Subject> addSubject(String teacherId, String subjectName) async {
    try {
      final docRef = _firestore.collection('subjects').doc();
      final subject = Subject(
        id: docRef.id,
        name: subjectName,
        teacherId: teacherId,
        createdAt: DateTime.now(),
      );

      await docRef.set(subject.toMap());
      return subject;
    } catch (e) {
      throw Exception('Failed to add subject: $e');
    }
  }

  // Get all subjects for a teacher
  Future<List<Subject>> getTeacherSubjects(String teacherId) async {
    try {
      final snapshot = await _firestore
          .collection('subjects')
          .where('teacherId', isEqualTo: teacherId)
          .get();

      final subjects = snapshot.docs
          .map((doc) => Subject.fromMap(doc.data(), doc.id))
          .toList();
      
      // Sort by createdAt in descending order (newest first)
      subjects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return subjects;
    } catch (e) {
      throw Exception('Failed to fetch subjects: $e');
    }
  }

  // Get a specific subject by ID
  Future<Subject?> getSubject(String subjectId) async {
    try {
      final doc = await _firestore.collection('subjects').doc(subjectId).get();
      if (doc.exists) {
        return Subject.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch subject: $e');
    }
  }

  // Delete a subject
  Future<void> deleteSubject(String subjectId) async {
    try {
      await _firestore.collection('subjects').doc(subjectId).delete();
    } catch (e) {
      throw Exception('Failed to delete subject: $e');
    }
  }
}
