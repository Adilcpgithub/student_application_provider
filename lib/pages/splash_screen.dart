import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_application_provider/pages/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    splashProvider.gotoHomeScreen(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Image.asset(
            "assets/AddStudent.jpg",
          ),
        ),
      ),
    );
  }
}

class SplashProvider extends ChangeNotifier {
  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return HomeScreen();
    }), (Route<dynamic> route) => false);
    notifyListeners();
  }
}
