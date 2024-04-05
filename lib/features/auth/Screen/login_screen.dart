import 'dart:developer';

import 'package:fee_verification_student/features/auth/rapo/auth_rapo.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _studentNameController = TextEditingController();
  final _studentRollNoController = TextEditingController();
  final _studentYearController = TextEditingController();
  final _studentBranchController = TextEditingController();
  bool _isLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _studentNameController.dispose();
    _studentRollNoController.dispose();
    _studentYearController.dispose();
    _studentBranchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isLogin ? 'Login' : 'Register'),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStateStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == AuthStateStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    if (!_isLogin) ...[
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _studentNameController,
                        decoration: InputDecoration(
                          labelText: 'Student Name',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _studentRollNoController,
                        decoration: InputDecoration(
                          labelText: 'Student Roll No.',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _studentYearController,
                        decoration: InputDecoration(
                          labelText: 'Student Year',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _studentBranchController,
                        decoration: InputDecoration(
                          labelText: 'Student Branch',
                        ),
                      ),
                    ],
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_isLogin) {
                          context.read<AuthBloc>().add(
                            SignInRequested(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            ),
                          );
                        } else {
                          context.read<AuthBloc>().add(
                            SignUpRequested(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              username: _usernameController.text.trim(),
                              studentName: _studentNameController.text.trim(),
                              studentRollNo:
                              _studentRollNoController.text.trim(),
                              studentYear: _studentYearController.text.trim(),
                              studentBranch:
                              _studentBranchController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: Text(_isLogin ? 'Login' : 'Register'),
                    ),
                    SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Don\'t have an account? Register'
                            : 'Already have an account? Login',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}