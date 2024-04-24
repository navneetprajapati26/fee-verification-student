class StudentModel {
  final String username;
  final String userId;
  final String userEmailId;
  final String studentName;
  final String studentRollNo;
  final String studentYear;
  final String studentBranch;
  final bool? isStudentVerified;

  StudentModel({
    required this.username,
    required this.userId,
    required this.userEmailId,
    required this.studentName,
    required this.studentRollNo,
    required this.studentYear,
    required this.studentBranch,
    this.isStudentVerified,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'userEmailId': userEmailId,
      'student_name': studentName,
      'student_roll_no': studentRollNo,
      'student_year': studentYear,
      'student_branch': studentBranch,
      'is_student_verified': isStudentVerified,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      username: map['username'] ?? '',
      userId: map['userId'] ?? '',
      userEmailId: map['userEmailId'] ?? '',
      studentName: map['student_name'] ?? '',
      studentRollNo: map['student_roll_no'] ?? '',
      studentYear: map['student_year'] ?? '',
      studentBranch: map['student_branch'] ?? '',
      isStudentVerified: map['is_student_verified'] ?? false,
    );
  }

  StudentModel copyWith({
    String? username,
    String? userId,
    String? userEmailId,
    String? studentName,
    String? studentRollNo,
    String? studentYear,
    String? studentBranch,
    bool? isStudentVerified,
  }) {
    return StudentModel(
      username: username ?? this.username,
      userId: userId ?? this.userId,
      userEmailId: userEmailId ?? this.userEmailId,
      studentName: studentName ?? this.studentName,
      studentRollNo: studentRollNo ?? this.studentRollNo,
      studentYear: studentYear ?? this.studentYear,
      studentBranch: studentBranch ?? this.studentBranch,
      isStudentVerified: isStudentVerified ?? this.isStudentVerified,
    );
  }

  @override
  String toString() {
    return 'StudentModel{username: $username, userId: $userId, userEmailId: $userEmailId, studentName: $studentName, studentRollNo: $studentRollNo, studentYear: $studentYear, studentBranch: $studentBranch, isStudentVerified: $isStudentVerified}';
  }
}