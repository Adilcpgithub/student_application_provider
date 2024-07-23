import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:student_application_provider/models/student_model.dart';
import 'package:student_application_provider/pages/splash_screen.dart';
import 'package:student_application_provider/provider/add_student_provider.dart';
import 'package:student_application_provider/provider/student_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(StudentAdapter());
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox<Student>('students');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AddStudentProvider(),
    ),
    ChangeNotifierProvider(create: (context) => SplashProvider()),
    ChangeNotifierProvider(create: (context) => StudentProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management App ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

// class AddStudentProvider extends ChangeNotifier {
//   File? _image;
//   File? get image => _image;

//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController userAgeController = TextEditingController();
//   final TextEditingController userClassController = TextEditingController();
//   final TextEditingController userGenderController = TextEditingController();

//   void setImage(File? newImage) {
//     _image = newImage;
//     notifyListeners();
//   }

//   void clearData() {
//     userNameController.clear();
//     userAgeController.clear();
//     userClassController.clear();
//     userGenderController.clear();
//     _image = null;
//     notifyListeners();
//   }
// }
