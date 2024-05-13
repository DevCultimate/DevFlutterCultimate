import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csc_picker/csc_picker.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String? _countryValue;
  String? _stateValue;
  String? _districtValue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });

      // Update the text field with the selected date
      _dateController.text = formatter.format(_selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Select Date',
                  border: OutlineInputBorder(),
                  helperText: 'Add the date for response',
                ),
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                controller: _dateController,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  hintText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
              const SizedBox(height: 10),
              const TextField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              CSCPicker(
                defaultCountry: CscCountry.India,
                showStates: true,
                showCities: true,
                flagState: CountryFlag.DISABLE,
                dropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                ),
                disabledDropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey.withOpacity(0.5),
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                ),
                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownHeadingStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                dropdownDialogRadius: 10.0,
                searchBarRadius: 10.0,
                onCountryChanged: (value) {
                  setState(() {
                    _countryValue = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    _stateValue = value;
                  });
                },
                onCityChanged: (value) {
                  setState(() {
                    _districtValue = value;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Implement submit functionality
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
