import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class EventPopUpEdit extends StatefulWidget {
  final DateTime selectedDay;

  EventPopUpEdit({required this.selectedDay});
  @override
  _EventPopUpEditState createState() => _EventPopUpEditState();
}

class _EventPopUpEditState extends State<EventPopUpEdit> {
  late DateTime _selectedDay;
  final _eventNameController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.selectedDay;
  }

  double _calculateContainerHeight(String text) {
    final numberOfLines = (text
        .split('\n')
        .length).toDouble();
    final lineHeight = 25.0;
    return numberOfLines * (0.8 * lineHeight) + 30.0;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 248, 229),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Új Esemény Létrehozása',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '${DateFormat('yyyy.MM.dd.').format(_selectedDay)} - dátumra ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              _buildAnimatedTextField(
                  "Esemény neve", _eventNameController.text, (value) {
                setState(() {
                  _eventNameController.text = value;
                });
              }),
              SizedBox(height: 12.0),
              _buildAnimatedTextField(
                  "Időpont", _eventTimeController.text, (value) {
                setState(() {
                  _eventTimeController.text = value;
                });
              }),
              SizedBox(height: 12.0),
              _buildAnimatedTextField(
                  "Helyszín", _eventLocationController.text, (value) {
                setState(() {
                  _eventLocationController.text = value;
                });
              }),
              SizedBox(height: 12.0),
              _buildAnimatedTextField(
                  "Leírás", _eventDescriptionController.text, (value) {
                setState(() {
                  _eventDescriptionController.text = value;
                });
              }),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber.shade200,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Mégsem",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var userId = FirebaseAuth.instance.currentUser?.uid;
                      await FirebaseFirestore.instance.collection('events').add(
                          {
                            'name': _eventNameController.text,
                            'date': _selectedDay,
                            'time': _eventTimeController.text,
                            'location': _eventLocationController.text,
                            'description': _eventDescriptionController.text,
                            'userId': userId,
                          });

                      _eventNameController.clear();
                      _eventTimeController.clear();
                      _eventLocationController.clear();
                      _eventDescriptionController.clear();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber.shade200,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Mentés",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField(String hintText, String value,
      ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _calculateContainerHeight(value),
        child: TextField(
          onChanged: onChanged,
          maxLines: null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[400],
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}