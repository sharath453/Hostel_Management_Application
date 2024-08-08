import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewOuting extends StatefulWidget {
  @override
  _ViewOutingState createState() => _ViewOutingState();
}

class _ViewOutingState extends State<ViewOuting> {
  List outing = [];

  Future<void> deleteOuting(String studentId) async {
    try {
      String uri = "http://localhost/myfolder/deleteouting.php";

      var response =
          await http.post(Uri.parse(uri), body: {"student_id": studentId});
      var result = jsonDecode(response.body);

      if (result['success'] == "true") {
        print("Record deleted");
        getRecords();
      } else {
        print("Failed to delete record");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getRecords() async {
    var uri = Uri.parse("http://localhost/myfolder/viewouting.php");
    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        setState(() {
          outing = jsonDecode(response.body);
        });
      } else {
        print("Failed to fetch data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outing Requests'),
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 115, 182, 237),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: outing.length,
        itemBuilder: (context, index) {
          final outingItem = outing[index];
          return Card(
            color: Color.fromARGB(255, 233, 233, 233),
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 115, 182, 237),
                radius: 30,
                child: Center(
                  child: Text(
                    outingItem['block'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                'Student ID: ${outingItem['student_id']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Room No: ${outingItem['room_no']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.done_rounded),
                onPressed: () {
                  deleteOuting(outingItem['student_id']);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
