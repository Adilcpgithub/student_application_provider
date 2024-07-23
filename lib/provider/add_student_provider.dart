import 'dart:io';

import 'package:flutter/material.dart';

class AddStudentProvider extends ChangeNotifier {
  File? _image;
  File? get image => _image;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userAgeController = TextEditingController();
  final TextEditingController userClassController = TextEditingController();
  final TextEditingController userGenderController = TextEditingController();

  void setImage(File? newImage) {
    _image = newImage;
    notifyListeners();
  }

  void clearData() {
    userNameController.clear();
    userAgeController.clear();
    userClassController.clear();
    userGenderController.clear();
    _image = null;
    notifyListeners();
  }
}
