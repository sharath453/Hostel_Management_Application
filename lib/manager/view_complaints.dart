import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewComplaints extends StatefulWidget {
  const ViewComplaints({Key? key}) : super(key: key);
  @override
  State<ViewComplaints> createState() => _ViewOutingState();
}

class _ViewOutingState extends State<ViewComplaints> {
  List complaints = [];

  Future<void> deletecomplaint(String room_no) async {
    try {
      String uri = "http://localhost/myfolder/deletecomplaints.php";

      var res = await http.post(Uri.parse(uri), body: {"room_no": room_no});
      var response = jsonDecode(res.body);
      if (response['success'] == "true") {
        print("record deleted");
        getrecord();
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    var uri = Uri.parse("http://localhost/myfolder/viewcomplaints.php");
    try {
      var response = await http.get(uri);

      setState(() {
        complaints = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Complaints'),
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
          itemCount: complaints.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 233, 233, 233),
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 115, 182, 237),
                  radius: 30,
                  child: Center(
                    child: Text(
                      complaints[index]['block'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Room No : ${complaints[index]['room_no']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Issue: ${complaints[index]['issue']}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: Icon(Icons.done_rounded),
                  onPressed: () {
                    deletecomplaint(complaints[index]['room_no']);
                  },
                ),
              ),
            );
          }),
    );
  }
}
