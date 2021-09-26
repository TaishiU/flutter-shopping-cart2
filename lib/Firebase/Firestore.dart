import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart2/Constants/Constants.dart';

class Firestore {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /*プロフィール関連*/
  Future<void> registerUser({
    required String userId,
    required String email,
  }) async {
    DocumentReference usersReference = usersRef.doc(userId);
    await usersReference.set({
      'userId': usersReference.id,
      'email': email,
    });
  }
}
