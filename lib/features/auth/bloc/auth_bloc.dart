import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fee_risipts/bloc/fee_receipt_bloc.dart';
import '../model/student_model.dart';
import '../repo/auth_rapo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  //final FeeReceiptBloc feeReceiptBloc;
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc({required this.authRepository,
    // required this.feeReceiptBloc
  }) : super(AuthState.initial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<GetUserModel>(_onGetUserModel);
    on<UpdateUserInfo>(_onUpdateUserInfo);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('sign up requested ${state}');

    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      final userCredential = await authRepository.signUp(
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
      );

      await authRepository.updateUserInfo(studentModel);

      emit(state.copyWith(
        status: AuthStateStatus.register,
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
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await authRepository.signIn(event.email, event.password);

      final studentModel = await authRepository.getUserInfo();

      if (studentModel != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', studentModel.userId);

        emit(state.copyWith(
          status: AuthStateStatus.login,
          user: studentModel,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStateStatus.error,
          errorMessage: 'User information not found',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetUserModel(
    GetUserModel event,
    Emitter<AuthState> emit,
  ) async {
    log('Get user model called', name: 'From AuthBloc getUserModel');
    emit(state.copyWith(status: AuthStateStatus.loading));
    log('Get user model called --- 1', name: 'From AuthBloc getUserModel');
    // try {
    final studentModel = await authRepository.getUserInfo();

    log('User info: ${studentModel.toString()}',
        name: 'From AuthBloc getUserModel');

    if (studentModel != null) {
      emit(state.copyWith(
        status: AuthStateStatus.loaded,
        user: studentModel,
      ));

      //feeReceiptBloc.add(GetFeeReceiptsByListOfIdEvent(studentIdList: studentModel.studentFeeReceiptsIdList!));

      // log('User info: ${studentModel.toMap()}', name: 'From AuthBloc');
    } else {
      log("1", error: 'User information not found');
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: 'User information not found',
      ));
    }
    // } catch (e) {
    //    log("${e.toString()}",error: 'User information not found');
    //   emit(state.copyWith(
    //     status: AuthStateStatus.error,
    //     errorMessage: e.toString(),
    //   ));
    // }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');

      await authRepository.signOut();
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

  Future<void> _onUpdateUserInfo(
    UpdateUserInfo event,
    Emitter<AuthState> emit,
  ) async {
    log('Update user info called', name: 'UpdateUserInfo From AuthBloc');
    emit(state.copyWith(status: AuthStateStatus.loading));
    // try {
    final studentModel = event.studentModel;

    await authRepository.updateUserInfo(studentModel);

    if (studentModel != null) {
      emit(state.copyWith(
        status: AuthStateStatus.loaded,
        user: studentModel,
      ));

      log('User info: ${studentModel.toString()}',
          name: 'UpdateUserInfo From AuthBloc ');
    } else {
      emit(state.copyWith(
        status: AuthStateStatus.error,
        errorMessage: 'User information not found',
      ));
    }
    // } catch (e) {
    //   emit(state.copyWith(
    //     status: AuthStateStatus.error,
    //     errorMessage: e.toString(),
    //   ));
    // }
  }
}
