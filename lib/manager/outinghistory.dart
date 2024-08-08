import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OutingHistory extends StatefulWidget {
  @override
  _OutingHistoryState createState() => _OutingHistoryState();
}

class _OutingHistoryState extends State<OutingHistory> {
  List outingHistory = [];

  Future<void> getHistory() async {
    var uri = Uri.parse("http://localhost/myfolder/outinghistory.php");
    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        setState(() {
          outingHistory = jsonDecode(response.body);
        });
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outing History'),
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 115, 182, 237),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: outingHistory.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: outingHistory.length,
              itemBuilder: (context, index) {
                final historyItem = outingHistory[index];
                return Card(
                  color: Color.fromARGB(255, 233, 233, 233),
                  margin: EdgeInsets.all(10),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 115, 182, 237),
                      radius: 30,
                      child: Center(
                        child: Text(
                          historyItem['block']?.substring(0, 1) ??
                              'N/A', // Use the first letter of the block
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      'Student ID: ${historyItem['student_id'] ?? 'N/A'}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4), // Add spacing
                        Text(
                          'Room No: ${historyItem['room_no'] ?? 'N/A'}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4), // Add spacing
                        Text(
                          'Deleted At: ${historyItem['deleted_at'] ?? 'N/A'}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
