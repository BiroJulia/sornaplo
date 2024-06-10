
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/signin_screen.dart';
// import 'package:image_picker/image_picker.dart';
void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

// Future<File?> pickImage(BuildContext context) async {
//   File? image;
//   try {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       image = File(pickedImage.path);
//     }
//   } catch (e) {
//     showSnackBar(context, e.toString());
//   }

//   return image;
// }

void showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Biztos ki szeretne lépni?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Mégsem"),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
            child: const Text("Igen, kijelentkezem"),
          ),
        ],
      );
    },
  );
}