import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Color.fromARGB(255,90,196,164),
      ),
      body: Center(
        child: Text('Contact Us Page'),
      ),
    );
  }
}
