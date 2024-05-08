import 'package:cultimate/forms/land_details.dart';
import 'package:flutter/material.dart';// Import the RegistrationForm widget

class FarmerRegistrationPage extends StatefulWidget {
  @override
  _FarmerRegistrationPageState createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Farmer Registration'),
          actions: [
            ElevatedButton.icon(
              onPressed: _showAddFormDialog, // Call _showAddFormDialog method when the button is pressed
              icon: Icon(Icons.add),
              label: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + 60.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TabBar(
                    tabs: [
                      Tab(text: 'Pending Requests'),
                      Tab(text: 'Ongoing Requests'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Pending Requests tab
            Center(
              child: Text('Pending Requests'),
            ),
            // Content for Ongoing Requests tab
            Center(
              child: Text('Ongoing Requests'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show the add form dialog
  void _showAddFormDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8, // Set height to 80% of the screen height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add Farmer",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LandDetails(), // Display the RegistrationForm widget
                  ),
                ),
              ),  
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  // Implement submit functionality here
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

}
