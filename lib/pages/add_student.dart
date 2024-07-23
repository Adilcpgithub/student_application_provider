import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_application_provider/models/student_model.dart';
import 'package:student_application_provider/pages/home_screen.dart';
import 'package:student_application_provider/provider/add_student_provider.dart';
import 'package:student_application_provider/provider/student_provider.dart';

// ignore: must_be_immutable
class AddDataScreen extends StatelessWidget {
  AddDataScreen({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userAgeController = TextEditingController();
  final TextEditingController _userClassController = TextEditingController();
  final TextEditingController _userGenderController = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final addStudentProvider = Provider.of<AddStudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: const Center(
          child: Text(
            "ADD STUDENT DATA",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.9),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Add New Student",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : AssetImage('assets/AddStudent.jpg') as ImageProvider,
            ),
            ElevatedButton(
              onPressed: _getImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                hintText: " Enter Full Name",
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _userAgeController,
              decoration: InputDecoration(
                hintText: " Enter Age",
                labelText: " Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _userClassController,
              decoration: InputDecoration(
                hintText: " Enter Class",
                labelText: " Class",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _userGenderController,
              decoration: InputDecoration(
                hintText: "Enter Gender ",
                labelText: " Gender",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 35),
            Row(
              children: [
                SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 70),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red[100],
                  ),
                  onPressed: () {
                    _userNameController.text = "";
                    _userAgeController.text = "";
                    _userClassController.text = "";
                    _userGenderController.text = "";
                    _image = null; // Clear the image without setState
                  },
                  child: Text(
                    "Clear Data",
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ),
                const SizedBox(width: 40),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green[100],
                  ),
                  onPressed: () async {
                    final userName = _userNameController.text;
                    final userAge = _userAgeController.text;
                    final userClass = _userClassController.text;
                    final userGender = _userGenderController.text;

                    if (userName.isEmpty ||
                        userAge.isEmpty ||
                        userClass.isEmpty ||
                        userGender.isEmpty) {
                      _showSnackBar(
                          context, 'Please fill all fields', Colors.red);
                      return;
                    }

                    final user = Student(
                      name: userName,
                      age: userAge,
                      studentClass: userClass,
                      gender: userGender,
                      imagePath: _image?.path,
                    );

                    studentProvider.addStudent(user);

                    _showSnackBar(
                        context, 'Data Saved Successfully', Colors.black);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }),
                        (Route<dynamic> route) =>
                            false); // Change to your route name
                  },
                  child: Text(
                    "Save Data",
                    style: TextStyle(color: Colors.green[400]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path); // Set the image without setState
    }
  }
}
