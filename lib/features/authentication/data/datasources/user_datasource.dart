import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/authentication/data/model/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = sl<FirebaseFirestore>();
    final FirebaseAuth _auth = sl<FirebaseAuth>();

  Future<void> updateUserProfile(UserDetails userDetails) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userDetails.toMap(), SetOptions(merge: true));
    } else {
      throw Exception('No authenticated user found');
    }
  }

  Future<UserDetails?> getUserDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return UserDetails.fromMap(doc.data()!);
      }
    }
    return null;
  }
}
