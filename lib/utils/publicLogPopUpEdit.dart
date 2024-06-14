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
    ingredients = widget.initialBrewData["ingredients"] ?? "";
    mashing = widget.initialBrewData["mashing"] ?? "";
    hopping = widget.initialBrewData["hopping"] ?? "";
    mainFermentation = widget.initialBrewData["mainFermentation"] ?? "";
    ripening = widget.initialBrewData["ripening"] ?? "";
    OG = widget.initialBrewData["OG"] ?? 0;
    FG = widget.initialBrewData["FG"] ?? 0;
    IBU = widget.initialBrewData["IBU"] ?? 0;
    SRM = widget.initialBrewData["SRM"] ?? 0;
    descriptionText = widget.initialBrewData["descriptionText"] ?? "";
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
                        widget.initialBrewData["mainFermentation"] = mainFermentation;
                        widget.initialBrewData["ripening"] = ripening;
                        widget.initialBrewData["OG"] = OG;
                        widget.initialBrewData["FG"] = FG;
                        widget.initialBrewData["IBU"] = IBU;
                        widget.initialBrewData["SRM"] = SRM;
                        widget.initialBrewData["descriptionText"] = descriptionText;
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
