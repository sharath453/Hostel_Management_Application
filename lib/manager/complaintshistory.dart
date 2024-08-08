import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewComplaintHistory extends StatefulWidget {
  const ViewComplaintHistory({Key? key}) : super(key: key);

  @override
  _ViewComplaintHistoryState createState() => _ViewComplaintHistoryState();
}

class _ViewComplaintHistoryState extends State<ViewComplaintHistory> {
  List<dynamic> complaintHistory = [];

  @override
  void initState() {
    super.initState();
    fetchComplaintHistory();
  }

  Future<void> fetchComplaintHistory() async {
    final Uri uri = Uri.parse('http://localhost/myfolder/complainthistory.php');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        setState(() {
          complaintHistory = jsonDecode(response.body);
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint History'),
        backgroundColor: Color.fromARGB(255, 115, 182, 237),
      ),
      body: ListView.builder(
        itemCount: complaintHistory.length,
        itemBuilder: (context, index) {
          final complaint = complaintHistory[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                'Block: ${complaint['block']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Room No: ${complaint['room_no']}'),
                  SizedBox(height: 5),
                  Text('Issue: ${complaint['issue']}'),
                  SizedBox(height: 5),
                  Text('Deleted At: ${complaint['deleted_at']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
