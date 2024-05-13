import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Color.fromARGB(255, 90, 196, 164),
      ),
      body: Center(
        child: WaterDropButton(),
      ),
    );
  }
}

class WaterDropButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(),
      color: Color.fromARGB(255, 90, 196, 164),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () async{
          // Call your function here
          await FlutterPhoneDirectCaller.callNumber('+919668185944');
        },
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

// void _onClick() async {
//   await FlutterPhoneDirectCaller.callNumber('9668185944');
//   print('Button Clicked!');
// }

}
