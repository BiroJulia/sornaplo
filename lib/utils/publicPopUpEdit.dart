import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sornaplo/utils/popUpBeers.dart';

class PublicPopUpEdit extends StatefulWidget {
  // final Map<String, dynamic> publicRecipeData;
  final void Function(Map<String, dynamic>) onSave;

  const PublicPopUpEdit({Key? key, required this.onSave}) : super(key: key);

  @override
  State<PublicPopUpEdit> createState() => _PublicPopUpEditState();
}

class _PublicPopUpEditState extends State<PublicPopUpEdit> {
  String selectedBeerType = "";
  String name = "";
  String description = "";
  List<String> beerListFromFirestore = [];

  String ingredients = "";
  String mashing = "";
  String hopping = "";
  String mainFermentation = "";
  String ripening = "";
  int OG = 0;
  int FG = 0;
  int IBU = 0;
  int SRM = 0;
  String descriptionText = "";

  @override
  void initState() {
    super.initState();
    fetchBeerTypes();
    // initializeFields();
  }

  // void initializeFields() {
  //   name = widget.publicRecipeData["name"] ?? "";
  //   selectedBeerType = widget.publicRecipeData["type"] ?? "";
  //   description = widget.publicRecipeData["smallDescription"] ?? "";
  //
  //   ingredients = widget.publicRecipeData["ingredients"] ?? "";
  //   mashing = widget.publicRecipeData["mashing"] ?? "";
  //   hopping = widget.publicRecipeData["hopping"] ?? "";
  //   mainFermentation = widget.publicRecipeData["mainFermentation"] ?? "";
  //   ripening = widget.publicRecipeData["ripening"] ?? "";
  //   OG = widget.publicRecipeData["OG"] ?? 0;
  //   FG = widget.publicRecipeData["FG"] ?? 0;
  //   IBU = widget.publicRecipeData["IBU"] ?? 0;
  //   SRM = widget.publicRecipeData["SRM"] ?? 0;
  //   descriptionText = widget.publicRecipeData["descriptionText"] ?? "";
  // }

  Future<void> fetchBeerTypes() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('beertype').get();
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
    return Material(
      child: FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
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
                            "smallDescription": description.isNotEmpty ? description : null,
                            "ingredients": ingredients,
                            "mashing": mashing,
                            "hopping": hopping,
                            "mainFermentation": mainFermentation,
                            "ripening": ripening,
                            "OG": OG,
                            "FG": FG,
                            "IBU": IBU,
                            "SRM": SRM,
                            "descriptionText": descriptionText,
                          };
                          widget.onSave(brewData);
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Töltsd ki az összes kötelező mezőt!'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Mentés",
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
                          selectedBeerType.isEmpty ? "válassz egy sörfajtát" : selectedBeerType,
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

                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      ingredients = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Alapanyagok",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      mashing = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Cefrézés",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      hopping = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Komlóadagolás",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      mainFermentation = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Főerjesztés",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      ripening = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Érlelés",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      OG = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "OG",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      FG = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "FG",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      IBU = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "IBU",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      SRM = int.tryParse(value) ?? 0;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "SRM",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      descriptionText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Leírás",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 50),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

