import 'package:flutter/material.dart';

class LogScreen extends StatefulWidget {
  final String beerName;

  const LogScreen({Key? key, required this.beerName}) : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.beerName), // Display the beer name in the app bar
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showPopup(); // Show the popup when the plus icon is pressed
            },
          ),
        ],
      ),
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add a Log Entry', // Customize the title of your popup
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Add form fields or other content for your popup
              // For example, you can add TextFields, buttons, etc.
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle the action when the button in the popup is pressed
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
