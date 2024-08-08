import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hostelproject/manager/manager_landing.dart';
import 'package:hostelproject/student/student_login_page.dart';

class ManagerLoginPage extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost/myfolder/managerlogin.php'),
        body: {
          'user_id': userIdController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          // Clear text fields
          userIdController.clear();
          passwordController.clear();

          // Show success message
          _showSuccessDialog(context, responseData['message']);
        } else {
          // Show error message
          _showErrorDialog(context, responseData['message']);
        }
      } else {
        // Show error message
        _showErrorDialog(context, 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Show error message
      _showErrorDialog(context, 'An error occurred: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Failed'),
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

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Successful'),
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
    ).then((_) {
      // Add a delay before navigating to the landing page
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManagerLanding()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 115, 182, 237),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.network(
                'https://alvas.org/wp-content/uploads/2019/06/logo-258x300.png',
                fit: BoxFit.contain,
                width: 150.0,
                height: 150.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Manager Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                hintText: 'User ID',
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size(150, 50),
              ),
              onPressed: () {
                login(context);
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Student login"),
            ),
          ],
        ),
      ),
    );
  }
}
