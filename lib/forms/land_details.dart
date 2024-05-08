import 'package:flutter/material.dart';

class LandDetails extends StatefulWidget {
  @override
  _LandDetailsState createState() => _LandDetailsState();
}

class _LandDetailsState extends State<LandDetails> {
  List<String> _ownershipValues = ["Own Land"]; // List to store ownership values for each form
  int _numberOfLandDetails = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_numberOfLandDetails < 2) {
                      setState(() {
                        _numberOfLandDetails++;
                        _ownershipValues.add("Own Land"); // Add default ownership value for the new form
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You can only add up to 2 land details."),
                        ),
                      );
                    }
                  },
                  child: Text('Add Land'),
                ),
                if (_numberOfLandDetails == 2) ...[
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _numberOfLandDetails--;
                        _ownershipValues.removeLast(); // Remove ownership value for the deleted form
                      });
                    },
                    child: Text('Delete Land'),
                  ),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        ...List.generate(
          _numberOfLandDetails,
          (index) => _buildLandDetailsBox(index + 1),
        ),
      ],
    );
  }

  Widget _buildLandDetailsBox(int landDetailsNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Land Details $landDetailsNumber",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Plot Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Khata',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Area (in acres)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Ownership',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Own Land',
                    groupValue: _ownershipValues[landDetailsNumber - 1],
                    onChanged: (value) {
                      setState(() {
                        _ownershipValues[landDetailsNumber - 1] = value.toString();
                      });
                    },
                  ),
                  Text('Own Land'),
                  Radio(
                    value: 'Leased',
                    groupValue: _ownershipValues[landDetailsNumber - 1],
                    onChanged: (value) {
                      setState(() {
                        _ownershipValues[landDetailsNumber - 1] = value.toString();
                      });
                    },
                  ),
                  Text('Leased'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
