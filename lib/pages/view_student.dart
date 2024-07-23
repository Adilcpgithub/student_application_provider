import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_application_provider/models/student_model.dart';

class ViewStudent extends StatelessWidget {
  final Student student;
  ViewStudent({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 225, 218, 218),
      ),
      body: Container(
        color: Color.fromARGB(255, 225, 218, 218),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 11, 11, 11)
                          .withOpacity(0.5), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: Offset(6, 6), // Offset (adjust as needed)
                    ),
                  ],
                ),
                child: CircleAvatar(
                  foregroundColor: const Color.fromARGB(255, 18, 16, 16),
                  backgroundColor: Colors.black12,
                  backgroundImage: student.imagePath != null
                      ? FileImage(File(student.imagePath!)) as ImageProvider
                      : AssetImage('assets/AddStudent.jpg'),
                  radius: 110,
                ),
              ),
              const SizedBox(height: 60),
              Card(
                color: Color.fromARGB(255, 213, 214, 214),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "User Full Details",
                      style: TextStyle(fontSize: 22, color: Colors.red[400]),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Age:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.age.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Student Class:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.studentClass,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Gender:",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            student.gender,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
