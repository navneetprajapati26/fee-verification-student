import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/Screen/login_screen.dart';
import '../../auth/bloc/auth_bloc.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        actions: <Widget>[
          TextButton(
            child: Text('Logout'),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStateStatus.logout) {
            Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == AuthStateStatus.error) {
              return Center(child: Text(state.errorMessage ?? 'Unknown error'));
            } else if (state.user != null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Username: ${state.user!.username}'),
                    Text('User ID: ${state.user!.userId}'),
                    Text('Email: ${state.user!.userEmailId}'),
                    Text('Student Name: ${state.user!.studentName}'),
                    Text('Student Roll No: ${state.user!.studentRollNo}'),
                    Text('Student Year: ${state.user!.studentYear}'),
                    Text('Student Branch: ${state.user!.studentBranch}'),
                    Text('Is Student Verified: ${state.user!.isStudentVerified}'),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No user information available'));
            }
          },
        ),
      ),
    );
  }
}