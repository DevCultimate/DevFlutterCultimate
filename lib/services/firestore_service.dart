import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isUserExists(String mobileNumber) async {
    try {
      String documentId = '+91$mobileNumber';
      // Check if the document with the given mobile number exists in the 'USER' collection
      DocumentSnapshot userDoc = await _firestore.collection('USER').doc(documentId).get();
      return userDoc.exists;
    } catch (e) {
      print('Error checking user existence: $e');
      throw e;
    }
  }

  Future<void> createUser({
    required String username,
    required String password,
    required String age,
    required String mobileNumber,
    required String pincode,
    required String familyMembers,
    required String acres,
    required String role,
    required bool loginStatus,
  }) async {
    try {
      bool userExists = await isUserExists(mobileNumber);
      if (userExists) {
        print('User already registered');
        // You can handle this case according to your application logic
        // For example, show a toast or navigate to a different screen
      } else {
        // Create a new document with the mobile number as the document ID
        await _firestore.collection('USER').doc("+91$mobileNumber").set({
          'username': username,
          'password': password,
          'age': age,
          'pincode': pincode,
          'familyMembers': familyMembers,
          'acres': acres,
          'role': role,
          'loginStatus': loginStatus,
        });
        print('User registered successfully');
        // You can handle the success case according to your application logic
        // For example, show a success message or navigate to a different screen
      }
    } catch (e) {
      print('Error creating user: $e');
      throw e;
    }
  }
}
