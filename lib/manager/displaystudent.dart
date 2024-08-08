import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List<dynamic> students = [];
  List<dynamic> filteredStudents = [];
  final TextEditingController searchController = TextEditingController();
  String selectedYear = 'All';
  List<String> years = ['All', '1', '2', '3', '4', 'MBA'];

  // AppBar color
  final Color appBarColor = Color.fromARGB(255, 115, 182, 237);

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost/myfolder/displaystudent.php'));
      if (response.statusCode == 200) {
        setState(() {
          students = json.decode(response.body);
          filteredStudents = students;
        });
      } else {
        _showErrorDialog("Failed to load data");
      }
    } catch (e) {
      _showErrorDialog("Exception caught: $e");
    }
  }

  Future<void> deleteStudent(String usn) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/myfolder/deletestudent.php'),
        body: {'usn': usn},
      );
      if (response.statusCode == 200 && response.body.trim() == '1') {
        setState(() {
          students.removeWhere((student) => student['usn'] == usn);
          filteredStudents.removeWhere((student) => student['usn'] == usn);
        });
        _showSuccessDialog("Student deleted successfully");
      } else {
        _showErrorDialog("Failed to delete student");
      }
    } catch (e) {
      _showErrorDialog("Exception caught: $e");
    }
  }

  void _filterStudents() {
    String searchTerm = searchController.text.toLowerCase();
    setState(() {
      filteredStudents = students.where((student) {
        bool matchesSearch = student['usn'].toLowerCase().contains(searchTerm);
        bool matchesYear =
            selectedYear == 'All' || student['year'] == selectedYear;
        return matchesSearch && matchesYear;
      }).toList();
    });
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Student List', style: TextStyle(fontWeight: FontWeight.bold)),
        toolbarHeight: 70,
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by USN',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onChanged: (value) => _filterStudents(),
                  ),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedYear,
                  items: years.map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value!;
                      _filterStudents();
                    });
                  },
                  hint: Text('Select Year',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                var student = filteredStudents[index];
                return Card(
                  color: appBarColor, // Match card color with AppBar
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${student['name']} (${student['usn']})',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'Year: ${student['year']} - Branch: ${student['branch']}\n'
                      'Phone: ${student['phone_number']}\n'
                      'Email: ${student['email']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      color: Colors.black, // Set icon color for visibility
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            content: Text(
                                'Are you sure you want to delete this student?',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Delete',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteStudent(student['usn']);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
