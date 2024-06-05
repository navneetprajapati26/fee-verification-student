import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../screen_setup/screen_setup.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {

  static final routeName = '/splashScreen';


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    String initialRoute = userId != null ? ScreenSetUp.routeName : AuthScreen.routeName;


    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.of(context).pushReplacementNamed(initialRoute);// Duration for the splash screen
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (context) => HomeScreen(),  // Replace with your home screen widget
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/Animation - 1717614767153.json',  // Replace with the path to your Lottie file
          width: 200,
          height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
