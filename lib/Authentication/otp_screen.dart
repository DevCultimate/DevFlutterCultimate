import 'package:cultimate/Screens/homepage.dart';
import 'package:cultimate/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OtpScreen extends StatefulWidget {
  final String verificationId; // Add this line
  final String username_;
  final String password_;
  final String age_;
  final String mobilnumber_;
  final String pincode_;
  final String familymember_;
  final String area_;
  final String role_;
  const OtpScreen({Key? key, required this.verificationId,
  required this.username_,
    required this.password_,
    required this.age_,
    required this.mobilnumber_,
    required this.pincode_,
    required this.familymember_,
    required this.area_,
    required this.role_,}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9E6DC), // Forest Green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildGlassContainer(
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildOtpFields(),
                  SizedBox(height: 20),
                  buildSubmitButton(),
                  SizedBox(height: 10),
                  buildResendButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGlassContainer({double? width, double? height, Widget? child}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

Widget buildOtpFields() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: List.generate(
      6,
      (index) => SizedBox(
        width: 40,
        height: 40,
        child: TextField(
          controller: _controllers[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(fontSize: 20, color: Colors.black),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.green, // Set border color to green
                width: 2, // Set border width
              ),

            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              // Move focus to the next text field when a character is entered
              if (index < 5) {
                FocusScope.of(context).nextFocus();
              }
            } else {
              // If the value is cleared, move focus to the previous text field
              if (index > 0) {
                FocusScope.of(context).previousFocus();
              }
            }
          },
        ),
      ),
    ),
  );
}

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        // Function to handle submitting OTP
        String otp = '';
        // Get the OTP from each text field and concatenate
        for (int i = 0; i < 6; i++) {
          otp += _controllers[i].text; 
        }
        try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otp,
        );
        // Sign in with the credential
        // await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigate to the home page after successful authentication
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('mnumber', "+91${widget.mobilnumber_}");
        FirestoreService().createUser(username: widget.username_,
         password: widget.password_,
         age: widget.age_, 
         mobileNumber: widget.mobilnumber_, 
         pincode: widget.pincode_, 
         familyMembers: widget.familymember_, 
         acres: widget.age_, 
         role: widget.role_, 
         loginStatus: true);
      } catch (e) {
        // Handle any errors
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
        print('OTP: $otp'); // Print OTP in string format
      },
      child: Text('Submit'),
    );
  }

  Widget buildResendButton() {
    return TextButton(
      onPressed: () {
        // Function to resend OTP
        
      },
      child: Text('Resend OTP'),
    );
  }
}