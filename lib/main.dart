import 'package:fee_verification_student/screen_setup/screen_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/Screen/login_screen.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repo/auth_rapo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userId');

  String initialRoute = userId != null ? ScreenSetUp.routeName : AuthScreen
      .routeName;

  runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          ScreenSetUp.routeName: (context) => ScreenSetUp(),
        },
      ),
    );
  }
}