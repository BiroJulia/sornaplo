import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sornaplo/utils/popUpBeers.dart';
import 'package:sornaplo/utils/publicLogPopUpEdit.dart';

class PublicPopUpEdit extends StatefulWidget {
  final void Function(Map<String, dynamic>) onNext;

  const PublicPopUpEdit({Key? key, required this.onNext}) : super(key: key);

  @override
  State<PublicPopUpEdit> createState() => _PublicPopUpEditState();
}

class _PublicPopUpEditState extends State<PublicPopUpEdit> {
  String selectedBeerType = "";
  String name = "";
  String description = "";
  List<String> beerListFromFirestore = [];

  @override
  void initState() {
    fetchBeerTypes();
    super.initState();
  }

  Future<void> fetchBeerTypes() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('beertype').get();

    for (var doc in querySnapshot.docs) {
      beerListFromFirestore.add(doc.id);
    }
  }

  void onBeerSelect(String beerType) {
    setState(() {
      selectedBeerType = beerType;
    });
  }
  double _calculateContainerHeight() {
    final numberOfLines = (description.split('\n').length).toDouble();
    final lineHeight = 25.0;
    return numberOfLines * lineHeight + 30.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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
                        if (name.isNotEmpty && selectedBeerType.isNotEmpty) {
                          Map<String, dynamic> brewData = {
                            "name": name,
                            "type": selectedBeerType,
                            "smallDescription":
                            description.isNotEmpty ? description : null,
                          };
                          widget.onNext(brewData);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Töltsd ki az összes kötelező mezőt!'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Következő",
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
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "A főzet neve",
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
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/smallbeericon.png",
                        width: 29,
                        height: 29,
                        color: const Color.fromARGB(255, 140, 140, 140),
                      ),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                              return PopUpBeers(
                                beerlist: beerListFromFirestore,
                                onPressed: onBeerSelect,
                              );
                            },
                          );
                        },
                        child: Text(
                          selectedBeerType.isEmpty
                              ? "válassz egy sörfajtát"
                              : selectedBeerType,
                          style: const TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic,
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _calculateContainerHeight(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            maxLines: 8,
                            onChanged: (value) {
                              setState(() {
                                description = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "Recept leírás",
                              hintStyle: TextStyle(
                                color: Colors.black38,
                                fontStyle: FontStyle.italic,
                                fontSize: 19,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.only(top: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}