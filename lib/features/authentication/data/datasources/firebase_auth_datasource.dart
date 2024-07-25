import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  //add for Phone sign In

  FirebaseDataSource({required this.firebaseAuth, required this.googleSignIn});

//------------------SignIn --Google ------------------------------------

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return (await firebaseAuth.signInWithCredential(credential)).user;
  }

//------------------SignIn --Email & Password ------------------------------------

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

//------------------SignUp --Email & Password ------------------------------------

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print('Error during sign-up: $e');
      }
      return null;
    }
  }

//------------------SignOut ------------------------------------

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

//------------------SignUp --Get the User ------------------------------------

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  //------------------SignUp -- PhoneNumber ------------------------------------

  late String _verificationId;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException error) {
        // ignore: avoid_print
        print("Phone Number Verification Failed : $error");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

//-----Function to sign in with phone number using the SMS code ----------------

  Future<void> signInWithCredential(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    await firebaseAuth.signInWithCredential(credential);
  }

  signInWithPhoneNumber(String smsCode) {}
}
