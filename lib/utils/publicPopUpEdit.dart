import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sornaplo/utils/popUpBeers.dart';

class PublicPopUpEdit extends StatefulWidget {
  final Function(Map<String, dynamic>,File?) onSave;

  const PublicPopUpEdit({Key? key, required this.onSave}) : super(key: key);

  @override
  State<PublicPopUpEdit> createState() => _PublicPopUpEditState();
}

class _PublicPopUpEditState extends State<PublicPopUpEdit> {
  String selectedBeerType = "";
  String name = "";
  String smallDescription = "";
  List<String> beerListFromFirestore = [];

  List<String> ingredients = [""];
  String mashing = "";
  String hopping = "";
  String mainFermentation = "";
  String ripening = "";
  int OG = 0;
  int FG = 0;
  int IBU = 0;
  int SRM = 0;
  String descriptionText = "";
  File? _image;

  @override
  void initState() {
    super.initState();
    fetchBeerTypes();
  }

  void _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_image != null) {
      try {
        final storageRef = FirebaseStorage.instance.ref().child('images').child('log_images').child(DateTime.now().toString());
        final uploadTask = storageRef.putFile(_image!);
        final snapshot = await uploadTask.whenComplete(() {});
        return await snapshot.ref.getDownloadURL();
      } catch (e) {
        print('Error uploading image: $e');
        return null;
      }
    }
    return null;
  }

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

  double _calculateContainerHeight(String text) {
    final numberOfLines = (text.split('\n').length).toDouble();
    final lineHeight = 25.0;
    return numberOfLines * (0.8 * lineHeight) + 30.0;
  }

  Widget _buildAnimatedTextField(String hintText, String value, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _calculateContainerHeight(value),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                maxLines: 15,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontSize: 19,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(top: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 248, 229),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber.shade200,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Mégsem",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              if (name.isNotEmpty && selectedBeerType.isNotEmpty) {
                                Map<String, dynamic> brewData = {
                                  "name": name,
                                  "type": selectedBeerType,
                                  "smallDescription": smallDescription.isNotEmpty ? smallDescription : null,
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
                                bool success = await widget.onSave(brewData, _image);
                                if (success) {
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Hiba történt a mentés során.'),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Töltsd ki az összes kötelező mezőt!'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber.shade200,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Mentés",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
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
                      _buildAnimatedTextField("Rövid leírás", smallDescription, (value) {
                        setState(() {
                          smallDescription = value;
                        });
                      }),
                      const SizedBox(height: 30),
                      ListTile(
                        title: const Text('Alapanyagok'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(ingredients.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        setState(() {
                                          ingredients[index] = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: ingredients[index],
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        ingredients.add('');
                                      });
                                    },
                                  ),
                                  if (index != 0)
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle),
                                      onPressed: () {
                                        setState(() {
                                          ingredients.removeAt(index);
                                        });
                                      },
                                    ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildAnimatedTextField("Cefrézés", mashing, (value) {
                        setState(() {
                          mashing = value;
                        });
                      }),
                      const SizedBox(height: 30),
                      _buildAnimatedTextField("Komlóadagolás", hopping, (value) {
                        setState(() {
                          hopping = value;
                        });
                      }),
                      const SizedBox(height: 30),
                      _buildAnimatedTextField("Főerjesztés", mainFermentation, (value) {
                        setState(() {
                          mainFermentation = value;
                        });
                      }),
                      const SizedBox(height: 30),
                      _buildAnimatedTextField("Érlelés", ripening, (value) {
                        setState(() {
                          ripening = value;
                        });
                      }),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  OG = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "OG",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  FG = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "FG",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  IBU = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "IBU",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  SRM = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "SRM",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      _buildAnimatedTextField("Megjegyzések", descriptionText, (value) {
                        setState(() {
                          descriptionText = value;
                        });
                      }),
                      const SizedBox(height: 80),
                      GestureDetector(
                        onTap: _getImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          width: 200,
                          height: 200,
                          child: _image != null
                              ? Image.file(_image!, fit: BoxFit.cover)
                              : Icon(Icons.add, size: 50, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
