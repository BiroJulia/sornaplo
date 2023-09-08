import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sornaplo/utils/popUpBeers.dart';

class PopUpEdit extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSave;

  const PopUpEdit({super.key, required this.onSave});

  @override
  State<PopUpEdit> createState() => _PopUpEditState();
}

class _PopUpEditState extends State<PopUpEdit> {
  DateTime initialDate = DateTime.now();
  final dateForm = DateFormat('dd-MM-yyyy');
  String selectedBeer = "";
  String name = "";
  List<String> beerListFromFirestore = []; // List to store beer types

  String _getFormattedDate(DateTime date) {
    String month = _getMonth(date.month);
    String day = date.day.toString();
    return '$month $day';
  }

  String _getMonth(int month) {
    List<String> months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month];
  }

  Future<void> _selectDate(BuildContext context) async {
    print(initialDate.toString());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) {
      setState(() {
        initialDate = picked;
      });
    }
  }

  @override
  void initState() {
    fetchBeerTypes();
    super.initState();
  }

  // Fetch beer types from Firestore
  Future<void> fetchBeerTypes() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('beertype').get();

    for (var doc in querySnapshot.docs) {
      beerListFromFirestore.add(doc.id);
    }
  }

  void onBeerSelect(String beerType) {
    setState(() {
      selectedBeer = beerType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Mégsem",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.onSave({
                      "name": name,
                      "date": initialDate,
                      "type": selectedBeer,
                      "rating": 0,
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Mentes",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: const InputDecoration(
                hintText: ("A főzet neve"),
                hintStyle: TextStyle(
                  fontSize: 26,
                  color: Colors.black87,
                  height: 0.67,
                  fontWeight: FontWeight.w500,
                ),
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 50),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            ///DATUM select
            ///
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 140, 140, 140),
                    size: 30,
                  ),
                  TextButton(
                      onPressed: () => {_selectDate(context)},
                      child: Text(
                        dateForm.format(initialDate),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 140, 140, 140),
                            fontSize: 19),
                      ))
                ],
              ),
            ),
            // const SizedBox(height: 10),

            //////// Beer Type
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  // const Icon(
                  //   Icons.local_drink_rounded,
                  //   color: Color.fromARGB(255, 140, 140, 140),
                  //   size: 28,
                  // ),
                  Image.asset(
                    "assets/images/smallbeericon.png",
                    width: 29,
                    height: 29,
                    color: const Color.fromARGB(255, 140, 140, 140),
                  ),
                  TextButton(
                      onPressed: () => {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) {
                                  return PopUpBeers(
                                      beerlist: beerListFromFirestore,
                                      // beerlist: ["Ale", "pale ale", "Brown ale"],
                                      onPressed: onBeerSelect);
                                })
                          },
                      child: Text(
                        selectedBeer.isEmpty
                            ? "válassz egy sörfajtát"
                            : selectedBeer,

                        /// inline if
                        style: const TextStyle(
                          color: Color.fromARGB(182, 140, 140, 140),
                          fontStyle: FontStyle.italic,
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
