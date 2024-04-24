part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String studentName;
  final String studentRollNo;
  final String studentYear;
  final String studentBranch;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.username,
    required this.studentName,
    required this.studentRollNo,
    required this.studentYear,
    required this.studentBranch,
  });

  @override
  List<Object> get props => [
    email,
    password,
    username,
    studentName,
    studentRollNo,
    studentYear,
    studentBranch,
  ];
}

class GetUserModel extends AuthEvent {}

class UpdateUserInfo extends AuthEvent {
  final StudentModel studentModel;

  const UpdateUserInfo(this.studentModel);

  @override
  List<Object> get props => [studentModel];}

class SignOutRequested extends AuthEvent {}
