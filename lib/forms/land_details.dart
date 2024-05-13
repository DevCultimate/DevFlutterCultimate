import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Land Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100.0, // Adjust height as needed
                child: Center(
                  child: Image.asset('assets/CultimateLogoAnimated.gif'), // Replace 'assets/logo.gif' with your logo path
                ),
              ),
              const SizedBox(height: 10),
              LandDetailsForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class LandDetailsForm extends StatefulWidget {
  @override
  _LandDetailsFormState createState() => _LandDetailsFormState();
}

class _LandDetailsFormState extends State<LandDetailsForm> {
  late TextEditingController _plotNumberController;
  late TextEditingController _khataController;
  late TextEditingController _areaController;
  late TextEditingController _ownerNameController;
  String _ownership = 'Own Land'; // New property to hold the selected ownership
  late String from_date;
  late String to_date;
  String status = "pending";

  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    _plotNumberController = TextEditingController();
    _khataController = TextEditingController();
    _areaController = TextEditingController();
    _ownerNameController = TextEditingController();
  }

  @override
  void dispose() {
    _plotNumberController.dispose();
    _khataController.dispose();
    _areaController.dispose();
    _ownerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Land Details",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _plotNumberController,
                decoration: InputDecoration(
                  labelText: 'Plot Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _khataController,
                decoration: InputDecoration(
                  labelText: 'Khata',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _areaController,
                decoration: InputDecoration(
                  labelText: 'Area (in acres)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ownership',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Own Land',
                    groupValue: _ownership, // Changed group value
                    onChanged: (value) {
                      setState(() {
                        _ownership = value.toString(); // Update ownership state
                      });
                    },
                  ),
                  const Text('Own Land'),
                  Radio(
                    value: 'Leased',
                    groupValue: _ownership, // Changed group value
                    onChanged: (value) {
                      setState(() {
                        _ownership = value.toString(); // Update ownership state
                      });
                    },
                  ),
                  const Text('Leased'),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ownerNameController,
                decoration: InputDecoration(
                  labelText: 'Name of the Owner',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              Container(
  decoration: BoxDecoration(
    border: Border.all(),
    borderRadius: BorderRadius.circular(5.0),
  ),
  child: CSCPicker(
    onCountryChanged: (value) {
      setState(() {
        _selectedCountry = value;
      });
    },
    onStateChanged: (value) {
      setState(() {
        _selectedState = value;
      });
    },
    onCityChanged: (value) {
      setState(() {
        _selectedCity = value;
      });
    },
    showStates: true,
    showCities: true,
    flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
  ),
),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'From Date',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context, true);
                          },
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'To Date',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _selectDate(context, false);
                          },
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _saveFormData();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          from_date = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          to_date = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  void _saveFormData() async {
    // Access Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get user input data
    final Map<String, dynamic> formData = {
      'plotNumber': _plotNumberController.text,
      'khata': _khataController.text,
      'area': _areaController.text,
      'ownership': _ownership, // Use the selected ownership
      'ownerName': _ownerNameController.text,
      'location': '$_selectedCountry -> $_selectedState -> $_selectedCity',
      'From': from_date,
      'To': to_date,
      'Status': status
    };
    if (
      _plotNumberController.text.isEmpty ||
      _khataController.text.isEmpty ||
      _areaController.text.isEmpty ||
      _ownerNameController.text.isEmpty ||
      _selectedCountry == null ||
      _selectedState == null ||
      _selectedCity == null
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fill All The Fields'),
        ),
      );
    } else {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedMobileNumber = prefs.getString('mnumber');

        DateTime now = DateTime.now();
        String formattedDateTime = DateFormat('yyyy_MM_dd_HH_mm_ss').format(now);
        await firestore.collection('USER').doc('$storedMobileNumber').collection('Land').doc(formattedDateTime).set(formData);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully')));
        Navigator.pop(context);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error occurred: $error')));
      }
    }
  }
}
