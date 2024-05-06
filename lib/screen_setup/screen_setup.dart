import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/bloc/auth_bloc.dart';
import '../features/fee_risipts/screen/all_fee_risipts.dart';
import '../features/user_info/screen/user_info_screen.dart';
class ScreenSetUp extends StatefulWidget {

  static final routeName = '/screenSetUp';

  const ScreenSetUp({Key? key}) : super(key: key);

  @override
  _ScreenSetUpState createState() => _ScreenSetUpState();
}

class _ScreenSetUpState extends State<ScreenSetUp> {

  @override
  void initState() {
    log('ScreenSetUp', name: 'ScreenSetUp');
    context.read<AuthBloc>().add(GetUserModel());
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _screens = [
    AllFeeReceipt(),
    UserInfoScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Fee Receipts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Info',
          ),
        ],
      ),
    );
  }
}
