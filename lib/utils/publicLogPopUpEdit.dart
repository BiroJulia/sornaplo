import 'package:flutter/material.dart';

class PublicLogPopUpEdit extends StatefulWidget {
  final Map<String, dynamic> initialBrewData;
  final void Function(Map<String, dynamic>) onSave;

  const PublicLogPopUpEdit({Key? key, required this.initialBrewData, required this.onSave}) : super(key: key);

  @override
  _PublicLogPopUpEditState createState() => _PublicLogPopUpEditState();
}

class _PublicLogPopUpEditState extends State<PublicLogPopUpEdit> {
  List<String> ingredients = [""];
  String mashing = "";
  String hopping = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Brew Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil(ModalRoute.withName('/publicPopUpEdit'));
                    },
                    child: const Text(
                      "Vissza",
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
                      widget.initialBrewData["ingredients"] = ingredients;
                      widget.initialBrewData["mashing"] = mashing;
                      widget.initialBrewData["hopping"] = hopping;
                      widget.onSave(widget.initialBrewData);
                      Navigator.of(context).pop();
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
              ListTile(
                title: Text('Alapanyagok'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(ingredients.length, (index) {
                    return Row(
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
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              ingredients.add('Új alapanyag');
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              ingredients.removeAt(index);
                            });
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
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
                ),
              ),
              const SizedBox(height: 30),
              TextField(
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
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
