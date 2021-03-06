import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_cart2/Firebase/Firestore.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? signedInUser = authResult.user;

      if (signedInUser != null) {
        Firestore().registerUser(
          userId: signedInUser.uid,
          email: email,
        );
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      print('something wrong with signUp...');
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void logout() {
    _auth.signOut();
  }

  Future sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
