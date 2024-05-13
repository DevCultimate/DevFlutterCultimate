import 'package:cultimate/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cultimate/Authentication/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController familyMembersController = TextEditingController();
  final TextEditingController acresController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  bool isVisible = false;
  final formKey = GlobalKey<FormState>();
  String? selectedRole;
  bool _isSigningUp = false;
  FirestoreService firestoreservice = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Username Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        if (!RegExp(r'^[A-Za-z][A-Za-z0-9_]*$')
                            .hasMatch(value)) {
                          return "Username must start with a letter and contain only letters, numbers, or underscores";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        if (!RegExp(
                                r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+]).{8,}$')
                            .hasMatch(value)) {
                          return "Password must contain at least one letter, one digit, and one special character";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Confirm Password Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Age Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: ageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Age is required";
                        }
                        if (value.length > 2) {
                          return "Age must be at most 2 digits long";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Mobile Number Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: mobileNumberController,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Mobile number is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Pincode Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: pincodeController,
                      maxLength: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Pincode is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          labelText: 'Pincode',
                          prefixIcon: Icon(Icons.pin_drop),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Number of Family Members Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: familyMembersController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Number of family members is required";
                        }
                        if (int.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          labelText: 'Number of Family Members',
                          prefixIcon: Icon(Icons.group),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Acres Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: TextFormField(
                      controller: acresController,
                      maxLength: 2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Number of acres is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Acres of Land',
                          prefixIcon: Icon(Icons.landscape),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Role Dropdown
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 147, 217, 196),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select a role";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_add),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'farmer',
                          child: Text('I am a farmer'),
                        ),
                        DropdownMenuItem(
                          value: 'LandOwner',
                          child: Text('I am looking for share farmers'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // SignUp Button
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 50, 39, 26)),
                    child: TextButton(
                      onPressed: _isSigningUp ? null : _signUp,

                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isSigningUp = true; // Show progress indicator
      });

      if(await firestoreservice.isUserExists(mobileNumberController.text)){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Go for login'),
          ),
        );
      }
      else{
      try {
        // Your sign-up logic
        // For example:
        bool userExists = await firestoreservice.isUserExists(mobileNumberController.text);
          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+91${mobileNumberController.text.toString()}',
            verificationCompleted: (PhoneAuthCredential credential) {
              // Auto-retrieval or instant validation of SMS code
              // You can directly sign in the user here
              ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration Successful'),
          ),
        );
            },
            verificationFailed: (FirebaseAuthException e) {
              // Handle verification failure
              print(e.message);
              ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
          ),
        );
            },
            codeSent: (String verificationId, int? resendToken) {
              // Navigate to OTP screen when code is sent
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OtpScreen(verificationId: verificationId,
                      username_: usernameController.text,
                      password_: passwordController.text,
                      age_: ageController.text,
                      mobilnumber_:mobileNumberController.text,
                      pincode_:pincodeController.text,
                      familymember_:familyMembersController.text,
                      area_:acresController.text,
                      role_:selectedRole.toString()),
                ),
              );
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              // Handle code auto-retrieval timeout
            },
          );
          ////////////////////////////////////

          
          setState(() {
            _isSigningUp = false; // Hide progress indicator
          });
        
      } catch (e) {
        // Handle sign-up errors
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong'),
          ),
        );

        setState(() {
          _isSigningUp = false; // Hide progress indicator
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
      }
      ////////place else brac
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fill All The Fields'),
          ),
        );
    }
  }
}
