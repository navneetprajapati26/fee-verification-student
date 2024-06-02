import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constents/constents.dart';
import '../../../screen_setup/screen_setup.dart';
import '../../../widget/dropdown_button.dart';
import '../../../widget/year_picker.dart';
import '../bloc/auth_bloc.dart';
import '../repo/auth_rapo.dart';

class AuthScreen extends StatefulWidget {

  static final routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _studentNameController = TextEditingController();
  final _studentRollNoController = TextEditingController();



  late final String _yearOfAdmission ;
  late final String _studentYear;
  late final String _studentBranch;


  bool _isLogin = false;

  bool _isPasswordHidden = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _studentNameController.dispose();
    _studentRollNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if (state.status == AuthStateStatus.login ) {
            Navigator.of(context).pushReplacementNamed(ScreenSetUp.routeName);
          }
          if (state.status == AuthStateStatus.register) {
            _isLogin = true;
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
                    obscureText: _isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  if (!_isLogin) ...[
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

                    YearPickerWidget(
                      startYear: 2000,
                      endYear: 2030,
                      onYearChanged: (year) {
                        print('Selected Year: $year');

                        setState(() {
                          _yearOfAdmission = year.toString();
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    CustomDropdownButton(
                      items:ListConstent.studentYear,
                      hint: 'Select student year',
                      onChanged: (value) {
                        print('Selected: $value');

                        setState(() {
                          _studentYear = value!;
                        });

                      },
                    ),
                    SizedBox(height: 16.0),
                    CustomDropdownButton(
                      items:ListConstent.branches,
                      hint: 'Select a branch',
                      onChanged: (value) {
                        print('Selected: $value');


                        setState(() {
                          _studentBranch = value!;
                        });
                      },
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
                            yearOfAdmission: _yearOfAdmission,
                            studentName: _studentNameController.text.trim(),
                            studentRollNo: _studentRollNoController.text.trim(),
                            studentYear: _studentYear,
                            studentBranch: _studentBranch,
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
    );
  }
}