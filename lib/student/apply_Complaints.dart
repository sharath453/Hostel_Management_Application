import 'package:flutter/material.dart';
import 'package:hostelproject/student/landingPage.dart';
import 'package:http/http.dart' as http;

class ApplyComplaints extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController blockController = TextEditingController();
  final TextEditingController roomNoController = TextEditingController();
  final TextEditingController issueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Complaints'),
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: blockController,
                  decoration: InputDecoration(
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
                SizedBox(height: 20),
                TextFormField(
                  controller: roomNoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                SizedBox(height: 20),
                TextFormField(
                  controller: issueController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Issue',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Issue is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitComplaint(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 115, 182, 237),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitComplaint(BuildContext context) async {
    Uri uri = Uri.parse('http://localhost/myfolder/complaint.php');

    Map<String, String> data = {
      'block': blockController.text,
      'roomNo': roomNoController.text,
      'issue': issueController.text,
    };

    try {
      http.Response response = await http.post(uri, body: data);

      if (response.statusCode == 200) {
        if (response.body == '1') {
          // Clear text controllers
          blockController.clear();
          roomNoController.clear();
          issueController.clear();

          // Show success dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('Complaint submitted successfully'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context)
                        .pop(); // Navigate back to the previous page
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
