import 'package:flutter/material.dart';

class LogScreen extends StatefulWidget {
  final Map<String, dynamic> beer;

  const LogScreen({Key? key, required this.beer}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final List<String> actionList = [
    'Fozes',
    'Komlozas',
    'Palackozas',
    'Bejegyzes'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beer['name']),
      ),
      floatingActionButton: FloatingActionButton(
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
              child: Text("asd"),
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
        // Build and return your popup content here
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add a Log Entry', // Customize the title of your popup
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Add form fields or other content for your popup
              // For example, you can add TextFields, buttons, etc.
              const SizedBox(height: 16.0),
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
                  })
            ],
          ),
        );
      },
    );
  }
}
