import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sornaplo/screens/public_log.dart';
import 'package:sornaplo/utils/colors_utils.dart';

import '../utils/publicLogPopUpEdit.dart';
import '../utils/publicPopUpEdit.dart';
import 'home_screen.dart';

class PublicRecipesScreen extends StatefulWidget {
  const PublicRecipesScreen({Key? key}) : super(key: key);

  @override
  State<PublicRecipesScreen> createState() => _PublicRecipesScreenState();
}

class _PublicRecipesScreenState extends State<PublicRecipesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _publicBrewStream;

  @override
  void initState() {
    super.initState();
    _publicBrewStream = const Stream<QuerySnapshot>.empty();
    _fetchPublicBrews();
  }

  Future<void> _fetchPublicBrews() async {
    setState(() {
      _publicBrewStream = _firestore.collection('publicBrews').snapshots();
    });
  }

  void addPublicBrew(Map<String, dynamic> brew) {
    _firestore.collection('publicBrews').add({
      'name': brew['name'],
      'type': brew['type'],
      'smallDescription': brew['smallDescription'],
      'ingredients': brew['ingredients'],
      'mashing': brew['mashing'],
      'hopping': brew['hopping'],
    });
  }

  void _navigateToPublicLogScreen(Map<String, dynamic> recipeData, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PublicLogScreen(recipeData: recipeData, recipeId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: hexStringToColor("EC9D00"),
        title: const Text('Publikus Receptek'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
            );
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _publicBrewStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/smallbeericon.png",
                    width: 100,
                    height: 100,
                    color: Colors.black26,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                    child: const Text(
                      "Még nincsenek publikus receptek.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var publicBrewData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    var id = snapshot.data!.docs[index].id;
                    _navigateToPublicLogScreen(publicBrewData, id);
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            publicBrewData["name"] ?? "",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            publicBrewData["type"] ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            publicBrewData["smallDescription"] ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: hexStringToColor("EC9D00"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PublicPopUpEdit(
                onNext: (brew) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return PublicLogPopUpEdit(
                          initialBrewData: brew,
                          onSave: (finalBrew) {
                            addPublicBrew(finalBrew);
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}