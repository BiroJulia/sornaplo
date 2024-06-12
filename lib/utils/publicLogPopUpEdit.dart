import 'package:flutter/material.dart';

class PublicLogPopUpEdit extends StatefulWidget {
  final Map<String, dynamic> initialBrewData;
  final void Function(Map<String, dynamic>) onSave;

  const PublicLogPopUpEdit({Key? key, required this.initialBrewData, required this.onSave}) : super(key: key);

  @override
  _PublicLogPopUpEditState createState() => _PublicLogPopUpEditState();
}

class _PublicLogPopUpEditState extends State<PublicLogPopUpEdit> {
  String ingredients = "";
  String mashing = "";
  String hopping = "";

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
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
