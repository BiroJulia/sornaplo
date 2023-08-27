import 'package:flutter/material.dart';
import 'package:sornaplo/utils/colors_utils.dart';

class LogScreen extends StatefulWidget {
  final Map<String, dynamic> beer;

  const LogScreen({Key? key, required this.beer}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final List<String> actionList = [
    'Főzés',
    'Hideg komlózás',
    'Palackozás',
    'Bejegyzés'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("EC9D00"),
        title: Text(
          widget.beer['name'],
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        onPressed: () {
          _showPopup();
        },
        child: const Icon(Icons.add),
      ),
      body: (widget.beer['logs'] != null
          ? const Center(
              child: Text("Yay"),
            )
          : const Center(
              child: Text(
                "Ez a napló még üres.\n A lenti + gombbal adhatod hozzá az első bejegyzést.\n\n Sok sikert az új főzethez!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
    );
  }

  void _showPopup() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
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
                ],
              ),
              // const Text(
              //   'Add a Log Entry',
              //   style: TextStyle(
              //     fontSize: 18.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const SizedBox(height: 18.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: actionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: InkWell(
                      child: Text(
                        actionList[index],
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      },
    );
  }
}
