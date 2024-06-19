import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sornaplo/screens/public_log.dart';
import 'package:sornaplo/utils/colors_utils.dart';

import '../utils/publicPopUpEdit.dart';

class PublicLogScreen extends StatefulWidget {
  final Map<String, dynamic> recipeData;
  final String recipeId;

  const PublicLogScreen({Key? key, required this.recipeData, required this.recipeId}) : super(key: key);

  @override
  _PublicLogScreenState createState() => _PublicLogScreenState();
}

class _PublicLogScreenState extends State<PublicLogScreen> {
  late Map<String, dynamic> recipeData;
  late String creatorId;

  @override
  void initState() {
    super.initState();
    recipeData = widget.recipeData;
    creatorId = recipeData['creatorId'];
  }


  String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  bool isRecipeCreator() {
    String? currentUserId = getCurrentUserId();
    return currentUserId != null && currentUserId == creatorId;
  }

  Future<bool> updateRecipe(Map<String, dynamic> updatedRecipe, File? image) async {
    try {
      // Firebase Firestore referenciája a 'publicBrews' gyűjteményre
      final recipeDocRef = FirebaseFirestore.instance.collection('publicBrews').doc(updatedRecipe['id']);

      // Ha van új kép, feltöltjük és a letöltési URL-t hozzáadjuk az adatokhoz
      if (image != null) {
        final storageRef = FirebaseStorage.instance.ref().child('recipe_images/${recipeDocRef.id}');
        final uploadTask = storageRef.putFile(image);
        final snapshot = await uploadTask.whenComplete(() => {});
        final downloadURL = await snapshot.ref.getDownloadURL();
        updatedRecipe['image'] = downloadURL;
      }

      // Recept frissítése a Firestore-ban
      await recipeDocRef.update(updatedRecipe);
      return true; // Sikeres frissítés esetén true értékkel térünk vissza
    } catch (e) {
      print('Hiba történt a recept frissítése közben: $e');
      return false; // Hibás esetben false értékkel térünk vissza
    }
  }
  void _editRecipe() {
    if (isRecipeCreator()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublicPopUpEdit(
            initialRecipeData: recipeData,  // Átadjuk a jelenlegi recept adatait
            onSave: (updatedRecipe, image) async {
              bool success = await updateRecipe(updatedRecipe, image);
              if (success) {
                setState(() {
                  recipeData = updatedRecipe;  // Frissítjük a helyi állapotot az új adatokkal
                });
                Navigator.of(context).pop();  // Bezárjuk a szerkesztő popup-ot
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Hiba történt a recept frissítése közben.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Csak a recept létrehozója szerkesztheti a receptet.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }



  void _deleteRecipe() {
    if (isRecipeCreator()) {
      FirebaseFirestore.instance
          .collection('publicBrews')
          .doc(widget.recipeId)
          .delete()
          .then((_) {
        Navigator.of(context).pop();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hiba történt a recept törlése közben.'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Csak a recept létrehozója törölheti a receptet.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: hexStringToColor("EC9D00"),
        title: Text(recipeData['name'] ?? 'Recept'),
        actions: [
          if (isRecipeCreator())
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _editRecipe();
                } else if (value == 'delete') {
                  _deleteRecipe();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Szerkesztés'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Törlés'),
                ),
                ),
              ],
            ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (recipeData['image'] != null && recipeData['image'].isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        recipeData['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Név: ${recipeData['name'] ?? ''}',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Típus: ${recipeData['type'] ?? ''}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Leírás: ${recipeData['smallDescription'] ?? ''}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              if (recipeData['ingredients'] != null && (recipeData['ingredients'] as List).isNotEmpty)
                _buildInfoCard('Összetevők', (recipeData['ingredients'] as List).join(', \n')),
              if (recipeData['mashing'] != null && recipeData['mashing'].isNotEmpty)
                _buildInfoCard('Cefrézés', recipeData['mashing']),
              if (recipeData['hopping'] != null && recipeData['hopping'].isNotEmpty)
                _buildInfoCard('Komlózás', recipeData['hopping']),
              if (recipeData['mainFermentation'] != null && recipeData['mainFermentation'].isNotEmpty)
                _buildInfoCard('Főerjesztés', recipeData['mainFermentation']),
              if (recipeData['ripening'] != null && recipeData['ripening'].isNotEmpty)
                _buildInfoCard('Érlelés', recipeData['ripening']),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (recipeData['OG'] != null && recipeData['OG'] != 0) _buildSmallInfoCard('OG', recipeData['OG'].toString()),
                  if (recipeData['FG'] != null && recipeData['FG'] != 0) _buildSmallInfoCard('FG', recipeData['FG'].toString()),
                  if (recipeData['IBU'] != null && recipeData['IBU'] != 0) _buildSmallInfoCard('IBU', recipeData['IBU'].toString()),
                  if (recipeData['SRM'] != null && recipeData['SRM'] != 0) _buildSmallInfoCard('SRM', recipeData['SRM'].toString()),
                ],
              ),

              if (recipeData['descriptionText'] != null && recipeData['descriptionText'].isNotEmpty)
                _buildInfoCard('Leírás', recipeData['descriptionText']),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: hexStringToColor("EC9D00")),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallInfoCard(String title, String content) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: hexStringToColor("EC9D00")),
              ),
              SizedBox(height: 5),
              Text(
                content,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
