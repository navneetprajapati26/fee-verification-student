import 'dart:async';
import 'dart:developer';
// import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../model/student_model.dart';
import '../rapo/auth_rapo.dart';

part 'auth_event.dart';
part 'auth_state.dart';
// part of 'auth_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc(this._authRepository) : super(AuthState.initial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event,
      Emitter<AuthState> emit,
      ) async {
    print('sign up requested ${state}');

    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final userCredential = await _authRepository.signUp(
        event.email,
        event.password,
      );

      final studentModel = StudentModel(
        username: event.username,
        userId: userCredential.user!.uid,
        userEmailId: event.email,
        studentName: event.studentName,
        studentRollNo: event.studentRollNo,
        studentYear: event.studentYear,
        studentBranch: event.studentBranch,
        isStudentVerified: false,
      );

      await _authRepository.updateUserInfo(studentModel);

      emit(state.copyWith(
        status: AuthStateStatus.loaded,
        user: studentModel,
      ));
      print('Sign up successful, state: ${state}');
    } catch (e) {
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
      print('Sign up failed, state: ${state}');
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event,
      Emitter<AuthState> emit,
      ) async {
    log('--------------------------> sign in requested 1 ${state.status}');
    emit(state.copyWith(status: AuthStateStatus.loading));
    log('--------------------------> sign in requested 2 ${state.status}');
    try {
      await _authRepository.signIn(event.email, event.password);
      log('--------------------------> sign in requested 3 ${state.status}');

      final studentModel = await _authRepository.getUserInfo();
      log('--------------------------> sign in requested 4 ${state.status}');

      if (studentModel != null) {
        log('--------------------------> sign in requested 5 ${state.status}');

        emit(state.copyWith(
          status: AuthStateStatus.loaded,
          user: studentModel,
        ));
        log('--------------------------> sign in requested 6 ${state.status}');

        log(state.user.toString());
      } else {
        log('--------------------------> sign in requested 7 ${state.status}');

        emit(state.copyWith(
          status: AuthStateStatus.error,
          errorMessage: 'User information not found',
        ));

        log('--------------------------> sign in requested 8 ${state.status}');

      }
    } catch (e) {
      log('--------------------------> sign in requested 9 ${state.status} and error is ${e.toString()}');

      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _authRepository.signOut();
      emit(state.copyWith(
        status: AuthStateStatus.logout,
        user: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}