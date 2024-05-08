import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromARGB(255,90,196,164),
      ),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
