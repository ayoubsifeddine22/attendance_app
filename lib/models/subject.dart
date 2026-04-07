class Subject {
  final String id;
  final String name;
  final String teacherId;
  final DateTime createdAt;

  Subject({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
      'createdAt': createdAt,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map, String docId) {
    return Subject(
      id: docId,
      name: map['name'] ?? '',
      teacherId: map['teacherId'] ?? '',
      createdAt: (map['createdAt']?.toDate() ?? DateTime.now()),
    );
  }
}
