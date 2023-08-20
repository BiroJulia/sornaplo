// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sornaplo/screens/otp_screen.dart';
// import 'package:sornaplo/utils/utils.dart';

// class AuthProvider extends ChangeNotifier {
//   bool _isSignedIn = false;
//   bool get isSignedIn => _isSignedIn;
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   AuthProvider() {
//     checkSign();
//   }

//   void checkSign() async {
//     final SharedPreferences s = await SharedPreferences.getInstance();
//     _isSignedIn = s.getBool("is_signedin") ?? false;
//     notifyListeners();
//   }

//   Future setSignIn() async {
//     final SharedPreferences s = await SharedPreferences.getInstance();
//     s.setBool("is_signedin", true);
//     _isSignedIn = true;
//     notifyListeners();
//   }

//   // signin
//   void signInWithPhone(BuildContext context, String phoneNumber) async {
//     try {
//       await _firebaseAuth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted:
//               (PhoneAuthCredential phoneAuthCredential) async {
//             await _firebaseAuth.signInWithCredential(phoneAuthCredential);
//           },
//           verificationFailed: (error) {
//             throw Exception(error.message);
//           },
//           codeSent: (verificationId, forceResendingToken) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OtpScreen(verificationId: verificationId),
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (verificationId) {});
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message.toString());
//     }
//   }
// }
