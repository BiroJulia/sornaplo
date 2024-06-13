import 'package:flutter/material.dart';

class PublicLogScreen extends StatefulWidget {
  final Map<String, dynamic> recipeData;

  const PublicLogScreen({Key? key, required this.recipeData, required  recipeId}) : super(key: key);

  @override
  _PublicLogScreenState createState() => _PublicLogScreenState();
}

class _PublicLogScreenState extends State<PublicLogScreen> {
  late Map<String, dynamic> recipeData;

  @override
  void initState() {
    super.initState();
    recipeData = widget.recipeData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeData['name'] ?? 'Recept'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Név: ${recipeData['name'] ?? ''}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              // Itt adhatók hozzá további részletek, például alapanyagok, cefrézés, komlóadagolás stb.
            ],
          ),
        ),
      ),
    );
  }
}
