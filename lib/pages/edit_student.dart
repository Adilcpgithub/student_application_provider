import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_application_provider/models/student_model.dart';
import 'package:student_application_provider/pages/home_screen.dart';
import 'package:student_application_provider/provider/student_provider.dart';

class EditStudent extends StatefulWidget {
  final Student student;
  final studetKey;
  EditStudent({super.key, required this.student, this.studetKey});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userAgeController = TextEditingController();
  final TextEditingController _userClassController = TextEditingController();
  final TextEditingController _userGenderController = TextEditingController();
  File? _image;
  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.student.name ?? '';
      _userClassController.text = widget.student.age ?? '';
      _userAgeController.text = widget.student.age ?? '';
      _userGenderController.text = widget.student.gender ?? '';

      if (widget.student.imagePath != null) {
        _image = File(widget.student.imagePath!);
      } else {
        _image = null;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
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
                    setState(() {
                      _image = null;
                    });
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

                    studentProvider.updateStudent(widget.studetKey, user);

                    _showSnackBar(
                        context, 'Data Saved Successfully', Colors.black);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) {
                      return HomeScreen();
                    }), (Route<dynamic> route) => false);
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
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
