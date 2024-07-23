import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_application_provider/pages/add_student.dart';
import 'package:student_application_provider/pages/edit_student.dart';
import 'package:student_application_provider/pages/view_student.dart';
import 'package:student_application_provider/provider/student_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                studentProvider.showSearch();
                searchController.text = '';
              },
              icon: const Icon(Icons.search))
        ],
        backgroundColor: Color.fromARGB(123, 15, 131, 102),
        title: const Center(
          child: Text(
            "   Student Information",
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: Column(
        children: [
          !studentProvider.isCheck
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    onChanged: (value) {
                      studentProvider.searchStudents(searchController.text);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'SEARCH HERE',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(16.0),
                    ),
                  ),
                ),
          Expanded(
            child: studentProvider.students.length == 0
                ? Center(
                    child: Text('Student list is empty'),
                  )
                : ListView.builder(
                    itemCount: searchController.text.isNotEmpty
                        ? studentProvider.filteredStudents.length
                        : studentProvider.students.length,
                    itemBuilder: (context, index) {
                      final student = searchController.text.isNotEmpty
                          ? studentProvider.filteredStudents[index]
                          : studentProvider.students[index];
                      final studentKey = studentProvider.getStudentKey(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Color.fromARGB(64, 129, 252, 172),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return ViewStudent(
                                  student: student,
                                );
                              }));
                              print(studentKey);
                            },
                            title: Text(
                              student.name ?? '',
                            ),
                            subtitle: Text(
                              student.gender ?? '',
                            ),
                            leading: CircleAvatar(
                              backgroundImage: student.imagePath != null
                                  ? FileImage(
                                      File(student.imagePath!),
                                    ) as ImageProvider
                                  : AssetImage('assets/AddStudent.jpg'),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return EditStudent(
                                        student: student,
                                        studetKey: index,
                                      );
                                    }));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(255, 1, 99, 29),
                                  ),
                                ),

                                //  delete button---------------------------------------
                                IconButton(
                                  onPressed: () {
                                    studentProvider
                                        .deleteStudentByKey(studentKey);
                                    // onDeleteStudent(index);
                                    if (studentProvider.isCheck) {
                                      // Navigator.of(context).pushAndRemoveUntil(
                                      //     MaterialPageRoute(builder: (ctx) {
                                      //   return HomeScreen();
                                      // }), (Route<dynamic> route) => false);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          )
        ],
      ),
      floatingActionButton: studentProvider.isCheck
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return AddDataScreen();
                }));
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
