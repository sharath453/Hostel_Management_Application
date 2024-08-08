import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String usn;

  ProfilePage({required this.usn});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> studentData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/myfolder/profile.php'), // Replace with your server URL
      body: {'usn': widget.usn},
    );

    if (response.statusCode == 200) {
      setState(() {
        studentData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load student data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 115, 182, 237),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : studentData.isEmpty
              ? Center(child: Text('Student not found'))
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 110, right: 110, top: 20),
                      child: Icon(
                        Icons.person,
                        size: 120,
                      ),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.pen),
                      title: Text(studentData['usn'] ?? 'USN'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(studentData['name'] ?? 'Name'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.codeBranch),
                      title: Text(studentData['branch'] ?? 'Branch'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.calendar),
                      title: Text(studentData['year'] ?? 'Year'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.code),
                      title: Text(studentData['block'] ?? 'Block'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.hotel),
                      title: Text(studentData['room_no'] ?? 'Room no'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.phone),
                      title: Text(studentData['phone'] ?? 'Phone'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.message),
                      title: Text(studentData['email'] ?? 'Email'),
                    ),
                  ],
                ),
    );
  }
}
