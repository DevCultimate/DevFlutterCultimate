import 'package:cloud_firestore/cloud_firestore.dart';

class LoginHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isNumberExists(String mobileNumber) async {
    try {
      String documentId = '+91$mobileNumber';
      // Check if the document with the given mobile number exists in the 'USER' collection
      DocumentSnapshot userDoc =
          await _firestore.collection('USER').doc(documentId).get();
      return userDoc.exists;
    } catch (e) {
      print('Error checking user existence: $e');
      throw e;
    }
  }

  Future<bool> verifyPassword(String mobileNumber, String password) async {
  try {
    String documentId = '+91$mobileNumber';
    // Get the document with the given mobile number
    DocumentSnapshot userDoc =
        await _firestore.collection('USER').doc(documentId).get();
    // Check if the document exists and if the password matches
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
    return userData != null && userData['password'] == password;
  } catch (e) {
    print('Error verifying password: $e');
    throw e;
  }
}

}
