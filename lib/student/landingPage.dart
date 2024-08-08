import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import the carousel_slider package
import 'package:hostelproject/student/apply_Complaints.dart';
import 'package:hostelproject/student/apply_Outing.dart';
import 'package:hostelproject/student/forgotpassword.dart';
import 'package:hostelproject/student/profilePage.dart';
import 'package:hostelproject/student/student_login_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'AIET'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ProfilePage(usn: '4AL21CS181')), // Pass the USN if required
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 115, 182, 237),
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          onPressed: _openDrawer,
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openProfilePage,
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 115, 182, 237),
              ),
              child: Text(
                'AIET',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            usn: '4AL21CS181'))); // Pass the USN if required
              },
            ),
            ListTile(
              leading: const Icon(Icons.pending_actions),
              title: const Text('Apply Outing'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ApplyOuting()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Apply Complaints'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ApplyComplaints()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text('Reset Password'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 320,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9, // Adjust aspect ratio as needed
                    viewportFraction: 1.0, // Adjust to fit the container width
                  ),
                  items: [
                    'https://alvas.org/wp-content/uploads/2016/05/Alvas-Engineering-Collage-768x307.jpg',
                    'https://thenfapost.com/wp-content/uploads/2020/09/TKM-joins-hands-with-Alvas-Institute-of-Engineering-and-Technology-for-faculty-and-student-skill-development-initiatives.jpg',
                    'https://i0.wp.com/content3.jdmagicbox.com/comp/dakshina_kannada/v6/9999px824.x824.170924184739.b3v6/catalogue/alva-s-engineering-college-boys-hostel-mijar-dakshina-kannada-hostel-for-boy-students-0uomqhlasi.jpg',
                  ]
                      .map((item) => Container(
                            width: 320, // Set the width to 320
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(item, fit: BoxFit.cover),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'VISION',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 320,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 169, 208, 239),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  '“Transformative education by pursuing excellence in Engineering and Management through enhancing skills to meet the evolving needs of the community”',
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'MISSION',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 320,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 169, 208, 239),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. To bestow quality technical education to imbibe knowledge, creativity and ethos to students community.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '2. To inculcate the best engineering practices through transformative education.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '3. To develop a knowledgeable individual for a dynamic industrial scenario.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '4. To inculcate research, entrepreneurial skills and human values in order to cater to the needs of society.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
