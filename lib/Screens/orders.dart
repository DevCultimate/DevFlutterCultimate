import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        backgroundColor: Color.fromARGB(255,90,196,164),
      ),
      body: Center(
        child: Text('Orders Page'),
      ),
    );
  }
}
