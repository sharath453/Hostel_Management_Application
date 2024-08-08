import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hostelproject/manager/complaintshistory.dart';
import 'package:hostelproject/manager/displaystudent.dart';
import 'package:hostelproject/manager/manager_login_page.dart';
import 'package:hostelproject/manager/outinghistory.dart';
import 'package:hostelproject/manager/register.dart';
import 'package:http/http.dart' as http;
import 'package:hostelproject/manager/view_complaints.dart';
import 'package:hostelproject/manager/view_outing.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ManagerLanding extends StatefulWidget {
  @override
  _ManagerLandingState createState() => _ManagerLandingState();
}

class _ManagerLandingState extends State<ManagerLanding> {
  Future<int> fetchTotalStatistics(String branch) async {
    try {
      final uri = Uri.parse(
          "http://localhost/myfolder/totalstatistics.php?branch=$branch");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('total')) {
          return int.tryParse(data['total'].toString()) ?? 0;
        } else if (data.containsKey('error')) {
          print("API Error: ${data['error']}");
          return 0;
        }
      } else {
        print("Failed to load statistics");
        return 0;
      }
    } catch (e) {
      print("Error: $e");
      return 0;
    }
    return 0;
  }

  Future<Map<String, int>> fetchBranchStatistics() async {
    final branches = [
      'CSE',
      'ISE',
      'ECE',
      'AG',
      'AIML',
      'ME',
      'CIV',
      'MBA',
    ];

    final stats = <String, int>{};
    for (String branch in branches) {
      final count = await fetchTotalStatistics(branch);
      stats[branch] = count;
    }
    return stats;
  }

  Future<int> fetchTotalStudentCount() async {
    return await fetchTotalStatistics('');
  }

  void _logout() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ManagerLoginPage())); // Replace with your login page route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 115, 182, 237),
        elevation: 0,
        title: Text('Manager'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.black,
            onPressed: _logout,
          ),
          SizedBox(
            width: 95,
          ),
          Image.network(
            'https://alvas.org/wp-content/uploads/2019/06/logo-258x300.png',
            fit: BoxFit.contain,
            width: 100.0,
            height: 100.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: double.maxFinite,
                  viewportFraction: 1.2,
                ),
                items: [
                  'https://alvas.org/wp-content/uploads/2016/05/Alvas-Engineering-Collage-768x307.jpg',
                  'https://thenfapost.com/wp-content/uploads/2020/09/TKM-joins-hands-with-Alvas-Institute-of-Engineering-and-Technology-for-faculty-and-student-skill-development-initiatives.jpg',
                  'https://i0.wp.com/content3.jdmagicbox.com/comp/dakshina_kannada/v6/9999px824.x824.170924184739.b3v6/catalogue/alva-s-engineering-college-boys-hostel-mijar-dakshina-kannada-hostel-for-boy-students-0uomqhlasi.jpg',
                ]
                    .map((item) => Container(
                          width: 320,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(item, fit: BoxFit.cover),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              FutureBuilder<int>(
                future: fetchTotalStudentCount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 115, 182, 237),
                      ),
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 115, 182, 237),
                      ),
                      height: 100,
                      child: Center(
                        child: Text('Error: ${snapshot.error}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    );
                  } else {
                    final totalStudents = snapshot.data ?? 0;
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromARGB(255, 115, 182, 237),
                      ),
                      height: 100,
                      child: Center(
                        child: Text(
                          'Total Students: $totalStudents',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 10),
              FutureBuilder<Map<String, int>>(
                future: fetchBranchStatistics(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    final branchStats = snapshot.data ?? {};
                    return _buildBranchGrid(branchStats);
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                "Explore",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 115, 182, 237),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Add Student",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentList()),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 115, 182, 237),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.view_agenda,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "View Student",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewComplaints()),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 115, 182, 237),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pending_actions,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "View Complaints",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewOuting()),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 115, 182, 237),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.book,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "View Outing",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewComplaintHistory()),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 115, 182, 237),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Complaints History",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OutingHistory()),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 115, 182, 237),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history_edu_outlined,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Outing History",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranchGrid(Map<String, int> branchStats) {
    final branches = [
      'CSE',
      'ISE',
      'ECE',
      'AG',
      'AIML',
      'ME',
      'CIV',
      'MBA',
    ];

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: branches.length,
      itemBuilder: (context, index) {
        final branch = branches[index];
        final count = branchStats[branch] ?? 0;
        return InkWell(
          onTap: () {
            // Handle branch selection or navigation
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 115, 182, 237),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                '$branch\n$count',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
