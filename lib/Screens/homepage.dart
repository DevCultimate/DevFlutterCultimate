import 'package:cultimate/Screens/request_farmer.dart';
import 'package:cultimate/Screens/add_farmers.dart';
import 'package:cultimate/screens/contactus.dart';
import 'package:cultimate/screens/orders.dart';
import 'package:cultimate/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          OrdersPage(),
          ContactUsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255,147,217,196),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            rippleColor:  Color.fromARGB(255, 35, 207, 35),
            tabBorderRadius: 15,
            tabBackgroundColor: Color.fromARGB(255,131,177,159),
            backgroundColor: Color.fromARGB(255,147,217,196),
            color: const Color.fromARGB(255,232,227,218),
            activeColor: const Color.fromARGB(255, 164,103,50),
            padding: const EdgeInsets.all(18),
            curve: Curves.linearToEaseOut,
            duration: Duration(milliseconds: 200),
            gap: 10,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(index,
                    duration:  Duration(milliseconds: 150),
                    curve: Curves.ease);
              });
            },
            tabs: [
              GButton (icon: Icons.home, text: 'Home'),
              GButton (icon: Icons.shopping_bag, text: 'Orders'),
              GButton (icon: Icons.contact_phone, text: 'Contact Us'),
              GButton (icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHomePage() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232,227,218),
      body: Column(
        children: [
          //AppBar
          AppBar(
            title: Text('Home'),
            backgroundColor: Color.fromARGB(255,90,196,164),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCardButton("assets/farmer.png", 'Request Farmer', () {
                  // Navigate to another screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RequestFarmers()));
                }),
                _buildCardButton("assets/add.png", 'Enroll Farmer', () {
                  // Navigate to another screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                }),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCardButton("assets/CultimateLogoAnimated.gif", 'Button 3', () {
                  // Navigate to another screen
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => YourScreen3()));
                }),
                _buildCardButton("assets/CultimateLogoAnimated.gif", 'Button 4', () {
                  // Navigate to another screen
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => YourScreen4()));
                }),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Image Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 200),
              viewportFraction: 0.8,
            ),
            items: [
              'assets/banner1.png',
              'assets/banner2.png',
              // 'assets/image3.jpg',
              // 'assets/image4.jpg',
              // 'assets/image5.jpg',
            ].map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

 Widget _buildCardButton(String pngPath, String buttonText, VoidCallback onTap) {
  return SizedBox(
    width: 150, // Set fixed width for uniformity
    height: 150, // Set fixed height for uniformity
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        backgroundColor: Colors.white, // Button background color
        foregroundColor: Colors.black, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Color.fromARGB(255, 195, 199, 81), width: 1.0), // Border
        ),
      ),
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80, // Adjust size as needed
            height: 80, // Adjust size as needed
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200], // Background color for circular avatar
            ),
            child: ClipOval(
              child: Image.asset(
                pngPath,
                fit: BoxFit.contain, // Maintain aspect ratio and fit inside
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}



}
