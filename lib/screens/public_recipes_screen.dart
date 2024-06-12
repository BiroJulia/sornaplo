import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sornaplo/utils/colors_utils.dart';

import '../utils/publicLogPopUpEdit.dart';
import '../utils/publicPopUpEdit.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: hexStringToColor("EC9D00"),
        title: const Text('Publikus Receptek'),
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
                var brewData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brewData["name"],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    subtitle: brewData["smallDescription"] != null
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          brewData["type"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          brewData["smallDescription"] ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    )
                        : Text(
                      brewData["type"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
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
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PublicLogPopUpEdit(
                        initialBrewData: brew,
                        onSave: (finalBrew) {
                          addPublicBrew(finalBrew);
                        },
                      );
                    },
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