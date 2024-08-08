// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController usnController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController roomNoController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController aadhaarController =
      TextEditingController(); // New controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Students'),
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 115, 182, 237),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 110, right: 110, top: 20),
                child: Icon(
                  Icons.person_add,
                  size: 120,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usnController,
                        decoration: InputDecoration(
                          labelText: "USN",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'USN is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: yearController,
                        decoration: InputDecoration(
                          labelText: "Year",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Year is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: branchController,
                        decoration: InputDecoration(
                          labelText: "Branch",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Branch is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: blockController,
                        decoration: InputDecoration(
                          labelText: "Block",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Block is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: roomNoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Room No",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Room No is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Phone number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        controller: aadhaarController, // New field
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Aadhaar No",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Aadhaar number is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Only proceed if all fields are valid
                            addData(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 115, 182, 237),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addData(BuildContext context) async {
    Uri uri = Uri.parse('http://localhost/myfolder/register.php');

    Map<String, String> data = {
      'usn': usnController.text,
      'name': nameController.text,
      'year': yearController.text,
      'branch': branchController.text,
      'block': blockController.text,
      'roomno': roomNoController.text,
      'phoneno': phoneNumberController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'aadhaar': aadhaarController.text, // Add this line
    };

    try {
      http.Response response = await http.post(uri, body: data);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body == '1') {
          // Clear the text controllers
          usnController.clear();
          nameController.clear();
          yearController.clear();
          branchController.clear();
          blockController.clear();
          roomNoController.clear();
          phoneNumberController.clear();
          emailController.clear();
          passwordController.clear();
          aadhaarController.clear(); // Clear the Aadhaar controller

          // Show success dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('Student added successfully'),
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
        } else {
          print("Error occurred: ${response.body}");
          _showErrorDialog(context, "Error occurred: ${response.body}");
        }
      } else {
        print("HTTP Error ${response.statusCode}");
        _showErrorDialog(context, "HTTP Error ${response.statusCode}");
      }
    } catch (e) {
      print("Exception caught: $e");
      _showErrorDialog(context, "Exception caught: $e");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
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
}
