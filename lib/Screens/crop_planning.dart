import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cultimate/models/crop_planning_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CropPlanningPage extends StatefulWidget {
  final String docId;

  CropPlanningPage({Key? key, required this.docId}) : super(key: key);

  @override
  _CropPlanningPageState createState() => _CropPlanningPageState();
}

class _CropPlanningPageState extends State<CropPlanningPage> {
  String selectedCrop = 'Crop A';
  String selectedYear = '2024';
  String selectedSeason = 'Spring';
  String selectedSeedType = 'Type A';
  int seedQuantity = 0;
  String selectedFertilizerType = 'Type X';
  int fertilizerQuantity = 0;
  String selectedPesticideType = 'Type P';
  int pesticideQuantity = 0;
  bool wantCredit = false;
  bool insurance = false;
  bool marketingSupport = false;
  String remarks = '';

  List<String> crops = ['Crop A', 'Crop B', 'Crop C']; 
  List<String> years = ['2024', '2025', '2026']; 
  List<String> seasons = ['Spring', 'Summer', 'Autumn', 'Winter']; 
  List<String> seedTypes = ['Type A', 'Type B', 'Type C']; 
  List<String> fertilizerTypes = ['Type X', 'Type Y', 'Type Z']; 
  List<String> pesticideTypes = ['Type P', 'Type Q', 'Type R']; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Planning'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowWithDropdown('Crop', selectedCrop, (value) {
              setState(() {
                selectedCrop = value.toString();
              });
            }, crops),
            _buildRowWithDropdown('Year', selectedYear, (value) {
              setState(() {
                selectedYear = value.toString();
              });
            }, years),
            _buildRowWithDropdown('Season', selectedSeason, (value) {
              setState(() {
                selectedSeason = value.toString();
              });
            }, seasons),
            _buildRowWithDropdown('Seed Type', selectedSeedType, (value) {
              setState(() {
                selectedSeedType = value.toString();
              });
            }, seedTypes),
            _buildRowWithQuantity('Seed Quantity', seedQuantity, (value) {
              setState(() {
                seedQuantity = int.tryParse(value) ?? 0;
              });
            }),
            _buildRowWithDropdown('Fertilizer Type', selectedFertilizerType, (value) {
              setState(() {
                selectedFertilizerType = value.toString();
              });
            }, fertilizerTypes),
            _buildRowWithQuantity('Fertilizer Quantity', fertilizerQuantity, (value) {
              setState(() {
                fertilizerQuantity = int.tryParse(value) ?? 0;
              });
            }),
            _buildRowWithDropdown('Pesticide Type', selectedPesticideType, (value) {
              setState(() {
                selectedPesticideType = value.toString();
              });
            }, pesticideTypes),
            _buildRowWithQuantity('Pesticide Quantity', pesticideQuantity, (value) {
              setState(() {
                pesticideQuantity = int.tryParse(value) ?? 0;
              });
            }),
            _buildRowWithCheckbox('Do you want Credit?', wantCredit, (value) {
              setState(() {
                wantCredit = value!;
              });
            }),
            if (wantCredit) ...[
              _buildRowWithQuantity('Enter Amount', 0, (value) {
                // Handle amount input
              }),
            ],
            _buildRowWithCheckbox('Insurance?', insurance, (value) {
              setState(() {
                insurance = value!;
              });
            }),
            _buildRowWithCheckbox('Marketing Support?', marketingSupport, (value) {
              setState(() {
                marketingSupport = value!;
              });
            }),
            _buildRemarksTextField(),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Save data to Firestore or perform any other action
                  _saveDataToFirestore();
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithDropdown(String label, String value, Function(String?) onChanged, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 2,
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithQuantity(String label, int value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                controller: TextEditingController(text: value.toString()),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildRemarksTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: null,
        decoration: InputDecoration(
          labelText: 'Remarks',
          hintText: 'Add any remarks...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {
          setState(() {
            remarks = value;
          });
        },
      ),
    );
  }
//////////////////////////////////////////////
///
///
///
///
///
///
///
///
///
///
///
void _saveDataToFirestore() async{
    // Validate form data
    if (_validateData()) {
      // Data is valid, create CropPlanning object
      CropPlanning cropPlanning = CropPlanning(
        selectedCrop: selectedCrop,
        selectedYear: selectedYear,
        selectedSeason: selectedSeason,
        selectedSeedType: selectedSeedType,
        seedQuantity: seedQuantity,
        selectedFertilizerType: selectedFertilizerType,
        fertilizerQuantity: fertilizerQuantity,
        selectedPesticideType: selectedPesticideType,
        pesticideQuantity: pesticideQuantity,
        wantCredit: wantCredit,
        insurance: insurance,
        marketingSupport: marketingSupport,
        remarks: remarks,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
        String? storedMobileNumber = prefs.getString('mnumber');

      // Save data to Firestore
      FirebaseFirestore.instance
          .collection('USER')
          .doc('$storedMobileNumber')
          .collection('Land')
          .doc(widget.docId)
          .collection('CropPlanning')
          .doc(widget.docId)
          .set(cropPlanning.toMap())
          .then((value) {
        // Data saved successfully
        print('Data saved to Firestore');
      }).catchError((error) {
        // Error saving data
        print('Error saving data: $error');
      });
    }
  }

  bool _validateData() {
    // Implement your validation logic here
    // Return true if data is valid, otherwise false
    // You can check if any field is empty or any other criteria
    // For example:
    if (selectedCrop.isEmpty || selectedYear.isEmpty) {
      // Show error message or handle invalid data
      return false;
    }
    return true;
  }




}
