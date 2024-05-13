import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cultimate/Screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // UI Themes
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ///////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CultiMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: ProfilePage(), // Display ProfilePage initially
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Add your variables here
  String _username = "";
  String _age = "0";
  String _role = "";
  String _familyMembers = "0";

  // Fetch user data from Firestore
  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedMobileNumber = prefs.getString('mnumber');
    // Implement fetching data from Firestore here
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("USER")
        .doc(storedMobileNumber)
        .get();

    setState(() {
      _username = userDoc.get('username');
      _age = userDoc.get('age');
      _role = userDoc.get('role');
      _familyMembers = userDoc.get('familyMembers');

    });
  }

  @override
  void initState() {
    super.initState();
    try {
      _fetchUserData();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255, 90, 196, 164),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Brand logo widget
            Image.asset(
              'assets/CultimateLogoAnimated.gif', // Replace with your brand logo image path
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            // Card with user details
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA1FFCE), Color(0xFFFAFFD1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField('Username', _username, Icons.person),
                  SizedBox(height: 10),
                  buildTextField('Age', _age, Icons.calendar_today),
                  SizedBox(height: 10),
                  buildTextField('Role', _role, Icons.work),
                  SizedBox(height: 10),
                  buildTextField('Family Members', _familyMembers, Icons.people),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Perform logout action here
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', false);
                        prefs.setString('mnumber', " ");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => SplashScreen()),
                          (route) => false,
                        );
                      },
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(icon, color: Colors.grey), // Change the icon as needed
          ),
          enabled: false,
          controller: TextEditingController(text: value),
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
