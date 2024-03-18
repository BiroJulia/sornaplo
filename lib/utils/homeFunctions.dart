import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sornaplo/screens/log.dart';
import 'package:sornaplo/screens/signin_screen.dart';
import 'package:sornaplo/utils/colors_utils.dart';
import 'package:sornaplo/utils/popUpEdit.dart';

void navigateToLogScreen(Map<String, dynamic> beerData, String beerId,BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LogScreen(beer: beerData, beerId: beerId),
    ),
  );
}

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Biztos ki szeretne lépni?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Bezárja a dialógust
            },
            child: Text("Mégsem"),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
            child: const Text("Igen, kijelentkezem"),
          ),
        ],
      );
    },
  );
}



