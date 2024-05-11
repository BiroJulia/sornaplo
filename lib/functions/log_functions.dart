import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';


// Future<bool> saveLogs(
//     String type,
//     String description,
//     DateTime selectedDate,
//     File? image,
//     Map<String, dynamic> beer,
//     String beerId,
//     Function setStateCallback,
//     ) async {
//   try {
//     List<Map<String, dynamic>> logs = [];
//
//     if (beer['logs'] != null) {
//       for (final element in beer['logs']) {
//         logs.add(element as Map<String, dynamic>);
//       }
//     }
//
//     // Kép feltöltése Firebase Storage-ba (ha van)
//     String? imageUrl;
//     if (image != null) {
//       final storageRef = FirebaseStorage.instance.ref().child('images').child('log_images').child(DateTime.now().toString());
//       final uploadTask = storageRef.putFile(image);
//       final snapshot = await uploadTask.whenComplete(() {});
//       imageUrl = await snapshot.ref.getDownloadURL();
//     }
//
//     logs.add({
//       type: {'description': description, 'date': selectedDate, 'image': imageUrl}
//     });
//
//     await FirebaseFirestore.instance
//         .collection('brews')
//         .doc(beerId)
//         .update({'logs': logs});
//
//     beer['logs'] = logs;
//     setStateCallback();
//
//     return true;
//   } catch (e) {
//     print('Hiba történt a naplóbejegyzés mentésekor: $e');
//     return false;
//   }
// }


// Future<bool> saveLogs(
//     String type,
//     String description,
//     DateTime selectedDate,
//     File? image,
//     String beerId,
//     Map<String, dynamic> beer,
//     Function setStateCallback,
//     ) async {
//   try {
//     List<Map<String, dynamic>> logs = [];
//
//     // Ha van már naplóbejegyzés, másold át őket a logs listába
//     if (beer['logs'] != null) {
//       for (final element in beer['logs']) {
//         logs.add(element as Map<String, dynamic>);
//       }
//     }
//
//     // Kép feltöltése Firebase Storage-ba (ha van)
//     String? imageUrl;
//     if (image != null) {
//       // Kép feltöltése és URL lekérése Firebase Storage-ból
//       final storageRef = FirebaseStorage.instance.ref().child('images').child('log_images').child(DateTime.now().toString());
//       final uploadTask = storageRef.putFile(image);
//       final snapshot = await uploadTask.whenComplete(() {});
//       imageUrl = await snapshot.ref.getDownloadURL();
//     }
//
//     // Naplóbejegyzés hozzáadása a logs listához
//     logs.add({
//       'type': type,
//       'description': description,
//       'selectedDate': selectedDate,
//       'image': imageUrl, // Kép URL-je vagy null
//     });
//
//     // Naplóbejegyzések frissítése a Firestore-ban
//     await FirebaseFirestore.instance.collection('brews').doc(beerId).update({
//       'logs': logs,
//     });
//
//     // Naplóbejegyzések frissítése a helyi állapotban és a setStateCallback meghívása
//     beer['logs'] = logs;
//     setStateCallback( );
//
//     // Sikeres mentés esetén true visszatérés
//     return true;
//   } catch (e) {
//     // Hibakezelés
//     print('Hiba történt a naplóbejegyzés mentésekor: $e');
//     return false;
//   }
// }

// Future<bool> saveLogs(
//     String type,
//     String description,
//     DateTime selectedDate
//     ) async {
//
//   List<Map<String, dynamic>> logs = [];
//
//   if (widget.beer['logs'] != null) {
//     for (final element in widget.beer['logs']) {
//       logs.add(element as Map<String, dynamic>);
//     }
//   }
//
//   logs.add({
//     type: {'description': description, 'date': selectedDate}
//   });
//   await _firestore
//       .collection('brews')
//       .doc(widget.beerId)
//       .update({'logs': logs});
//   widget.beer['logs'] = logs;
//   setState(() {});
//   return true;
// }

