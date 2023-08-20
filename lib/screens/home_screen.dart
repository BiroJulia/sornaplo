import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:sornaplo/screens/popUpEdit.dart';
import 'package:sornaplo/screens/signin_screen.dart';
// import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final List SavedBeerCards = [];
  // void addBeer(beer) {
  //   setState(() {
  //     SavedBeerCards.add(beer);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///////APP BAR

      appBar: AppBar(
        title: const Text("Sornaplo"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // showModalBottomSheet(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10.0),
              //     ),
              //     backgroundColor: Colors.white,
              //     context: context,
              //     builder: (context) {
              //       return Container();
              //       // popUpEdit(
              //       //   onSave: addBeer,
              //       // );
              //     });
            },
          ),
        ],
      ),
      body:
          // Container()
          Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("Signed Out");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            });
          },
        ),
      ),
    );
  }
}
