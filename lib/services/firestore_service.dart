import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String username,
    required String password,
    required String age,
    required String mobileNumber,
    required String pincode,
    required String familyMembers,
    required String acres,
    required String role,
  }) async {
    try {
      await _firestore.collection('USER').doc(mobileNumber).set({
        'username': username,
        'password': password,
        'age': age,
        'mobileNumber': mobileNumber,
        'pincode': pincode,
        'familyMembers': familyMembers,
        'acres': acres,
        'role': role,
      });
    } catch (e) {
      print('Error creating user: $e');
      throw e;
    }
  }
}





















// await _firestoreService.createUser(
//             username: username,
//             password: password,
//             age: age,
//             pincode: pincode,
//             mobileNumber: mobileNumber,
//             familyMembers: familyMembers,
//             acres: acres,
//             role: role,
//           );
