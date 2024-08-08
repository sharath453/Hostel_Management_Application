import 'package:flutter/material.dart';
import 'package:hostelproject/student/landingPage.dart';
import 'package:http/http.dart' as http;

class ApplyOuting extends StatelessWidget {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController roomNoController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Outing'),
        toolbarHeight: 70,
        backgroundColor: Color.fromARGB(255, 115, 182, 237),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                controller: studentIdController,
                decoration: InputDecoration(
                  hintText: 'Enter Student ID',
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Student ID is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: blockController,
                decoration: InputDecoration(
                  hintText: 'Enter Block',
                  labelText: 'Block',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Block is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: roomNoController,
                decoration: InputDecoration(
                  hintText: 'Enter Room No',
                  labelText: 'Room No',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Room No is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    submitData(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 115, 182, 237),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitData(BuildContext context) async {
    Uri uri = Uri.parse('http://localhost/myfolder/outing.php');
    Map<String, String> data = {
      'student_id': studentIdController.text,
      'block': blockController.text,
      'room_no': roomNoController.text,
    };

    try {
      http.Response response = await http.post(uri, body: data);

      if (response.statusCode == 200) {
        if (response.body == '1') {
          // Clear the text controllers
          studentIdController.clear();
          blockController.clear();
          roomNoController.clear();

          // Show success dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('Outing applied successfully'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          print('Failed to submit data. Error: ${response.body}');
        }
      } else {
        print('HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Exception caught: $e');
    }
  }
}
