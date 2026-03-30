class AttendanceRecord {
  final String id;
  final String studentId;
  final String subjectId;
  final String subjectName;
  final DateTime timestamp;

  AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.subjectName,
    required this.timestamp,
  });

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'timestamp': timestamp,
    };
  }

  // Create from Firestore document
  factory AttendanceRecord.fromMap(Map<String, dynamic> map, String docId) {
    return AttendanceRecord(
      id: docId,
      studentId: map['studentId'] ?? '',
      subjectId: map['subjectId'] ?? '',
      subjectName: map['subjectName'] ?? '',
      timestamp: (map['timestamp']?.toDate() ?? DateTime.now()),
    );
  }
}
