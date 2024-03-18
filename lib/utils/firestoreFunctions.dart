import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



Future<dynamic> fetchBrews() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> brewStream = FirebaseFirestore.instance
      .collection('brews')
      .where('userId', isEqualTo: userId)
      .snapshots();

  return brewStream;
}

// Fetch available years from Firestore
Future<Set<int>> fetchAvailableYears(FirebaseFirestore firestore) async {
  Set<int> years = {};

  try {
    QuerySnapshot querySnapshot = await firestore.collection('brews').get();
    querySnapshot.docs.forEach((doc) {
      DateTime date = doc['date'].toDate();
      years.add(date.year);
    });
  } catch (error) {
    print('Error fetching available years: $error');
  }

  return years;
}