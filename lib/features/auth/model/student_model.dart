class StudentModel {
  final String username;
  final String userId;
  final String userEmailId;
  final String studentName;
  final String studentRollNo;
  final String studentYear;
  final String studentBranch;
  final bool? isStudentVerified;
  final List<String>? studentFeeReceiptsIdList ;

  StudentModel({
    required this.username,
    required this.userId,
    required this.userEmailId,
    required this.studentName,
    required this.studentRollNo,
    required this.studentYear,
    required this.studentBranch,
    this.studentFeeReceiptsIdList,
    this.isStudentVerified,
  });


  @override
  String toString() {
    return 'StudentModel{username: $username, userId: $userId, userEmailId: $userEmailId, studentName: $studentName, studentRollNo: $studentRollNo, studentYear: $studentYear, studentBranch: $studentBranch, isStudentVerified: $isStudentVerified, studentFeeReceiptsIdList: $studentFeeReceiptsIdList}';
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'userId': this.userId,
      'userEmailId': this.userEmailId,
      'studentName': this.studentName,
      'studentRollNo': this.studentRollNo,
      'studentYear': this.studentYear,
      'studentBranch': this.studentBranch,
      'isStudentVerified': this.isStudentVerified,
      'studentFeeReceiptsIdList': this.studentFeeReceiptsIdList,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      username: map['username'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      userEmailId: map['userEmailId'] as String? ?? '',
      studentName: map['studentName'] as String? ?? '',
      studentRollNo: map['studentRollNo'] as String? ?? '',
      studentYear: map['studentYear'] as String? ?? '',
      studentBranch: map['studentBranch'] as String? ?? '',
      isStudentVerified: map['isStudentVerified'] as bool? ?? false,
      studentFeeReceiptsIdList: (map['studentFeeReceiptsIdList'] as List<dynamic>?)?.map((item) => item as String).toList() ?? [],
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
    List<String>? studentFeeReceiptsIdList,
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
      studentFeeReceiptsIdList:
          studentFeeReceiptsIdList ?? this.studentFeeReceiptsIdList,
    );
  }
}