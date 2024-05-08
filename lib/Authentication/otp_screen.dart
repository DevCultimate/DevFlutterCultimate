import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final verificationid;
   const OtpScreen({Key? key, required this.verificationid}) : super(key: key);

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
        // try{
        //   PhoneAuthCredential credential=
        //   await PhoneAuthProvider.credential(
        //     verificationId: widget.verificationid, smsCode: otp);
        // }catch(ex){

        // }
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
