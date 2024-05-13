import 'package:cultimate/Screens/crop_planning.dart';
import 'package:cultimate/forms/land_details.dart';
import 'package:cultimate/models/farmer_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestFarmers extends StatefulWidget {
  @override
  _RequestFarmersState createState() => _RequestFarmersState();
}

class _RequestFarmersState extends State<RequestFarmers> {
  List<FarmerRequest> allRequests = [];
  List<FarmerRequest> filteredRequests = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedMobileNumber = prefs.getString('mnumber');
      // Fetch data from Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('USER')
          .doc(storedMobileNumber)
          .collection('Land')
          .get();

      List<FarmerRequest> requests = snapshot.docs.map((doc) {
        String name = doc['ownerName'];
        String plotNo = doc['plotNumber'];
        String fromDate = doc['From'];
        String toDate = doc['To'];
        String khata = doc['khata'];
        String status = doc['Status'].toString().toLowerCase();
        String docId = doc.id;

        return FarmerRequest(
          name,
          status,
          'assets/CultimateLogoAnimated.gif',
          docId,
          fromDate,
          toDate,
          plotNo,
          khata,
        );
      }).toList();

      setState(() {
        allRequests = requests;
        filteredRequests = requests;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _filterRequests(String query) {
    setState(() {
      filteredRequests = allRequests.where((request) {
        return request.name.toLowerCase().contains(query.toLowerCase()) ||
            request.plotNo.toLowerCase().contains(query.toLowerCase()) ||
            request.khata.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Farmer Registration'),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LandDetailsScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight + 60.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: searchController,
                    onChanged: _filterRequests,
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
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: TabBarView(
            children: [
              _buildRequestList(filteredRequests.where((request) => request.status == 'pending').toList()),
              _buildRequestList(filteredRequests.where((request) => request.status == 'ongoing').toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestList(List<FarmerRequest> requests) {
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/CultimateLogoAnimated.gif'),
            ),
            title: Text('Owner Name: ${requests[index].name}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ordered from: ${requests[index].fromDate}'),
                Text('Ordered to: ${requests[index].toDate}'),
                Text('Plot Number: ${requests[index].plotNo}'),
                Text('Khata No: ${requests[index].khata}'),
              ],
            ),
            trailing: TextButton(
              onPressed: () {
                _navigateToCropPlanningPage(context, requests[index].docId);
              },
              child: Text('Crop Planning'),
            ),
          ),
        );
      },
    );
  }

  void _navigateToCropPlanningPage(BuildContext context, String docId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CropPlanningPage(docId: docId)),
    );
  }
}
