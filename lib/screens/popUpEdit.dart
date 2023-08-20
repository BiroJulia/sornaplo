import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sornaplo/screens/popUpBeers.dart';

class popUpEdit extends StatefulWidget {
  final void Function(dynamic) onSave;
  const popUpEdit({super.key, required this.onSave});

  @override
  State<popUpEdit> createState() => _popUpEditState();
}

class _popUpEditState extends State<popUpEdit> {
  DateTime initialDate = DateTime.now();
  final dateForm = new DateFormat('dd-MM-yyyy');
  String selectedBeer = "";

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

  void onBeerSelect(String beerType) {
    setState(() {
      selectedBeer = beerType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /////Felugro ablak
      ///

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
                  ),
                ),
              ),
              const Spacer(),
              
              // TextButton(
              //   onPressed: () {
              //     widget.onSave({
              //       "name": "elso sor",
              //       "date": initialDate,
              //       "type": selectedBeer
              //     });
              //     Navigator.of(context).pop();
              //   },
              //   child: const Text(
              //     "Mentes",
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: ("A fozet neve"),
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 30),
            ),
          ),

          ///DATUM select
          ///
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(255, 140, 140, 140),
                  size: 28,
                ),
                TextButton(
                    onPressed: () => {_selectDate(context)},
                    child: Text(
                      dateForm.format(initialDate),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 140, 140, 140),
                          fontSize: 17),
                    ))
              ],
            ),
          ),
          // const SizedBox(height: 10),

          //////// Beer Type
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Row(
              children: [
                const Icon(
                  Icons.local_drink_rounded,
                  color: Color.fromARGB(255, 140, 140, 140),
                  size: 28,
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
                                    beerlist: ["Ale", "pale ale", "Brown ale"],
                                    onPressed: onBeerSelect);
                              })
                        },
                    child: Text(
                      selectedBeer.length == 0
                          ? "Valassz egy sorfajtat"
                          : selectedBeer,

                      /// inline if
                      style: const TextStyle(
                          color: Color.fromARGB(255, 140, 140, 140),
                          fontSize: 17),
                    ))
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
