import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventPopUpEdit extends StatefulWidget {
  @override
  _EventPopUpEditState createState() => _EventPopUpEditState();
}

class _EventPopUpEditState extends State<EventPopUpEdit> {
  DateTime _selectedDay = DateTime.now();
  final _eventNameController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Új Esemény Létrehozása'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _eventNameController,
              decoration: InputDecoration(labelText: 'Esemény Neve'),
            ),
            TextField(
              controller: _eventTimeController,
              decoration: InputDecoration(labelText: 'Időpont'),
            ),
            TextField(
              controller: _eventLocationController,
              decoration: InputDecoration(labelText: 'Helyszín'),
            ),
            TextField(
              controller: _eventDescriptionController,
              decoration: InputDecoration(labelText: 'Leírás'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Mégse'),
        ),
        TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance.collection('events').add({
              'name': _eventNameController.text,
              'date': _selectedDay,
              'time': _eventTimeController.text,
              'location': _eventLocationController.text,
              'description': _eventDescriptionController.text,
            });

            _eventNameController.clear();
            _eventTimeController.clear();
            _eventLocationController.clear();
            _eventDescriptionController.clear();
            Navigator.of(context).pop();
          },
          child: Text('Mentés'),
        ),
      ],
    );
  }
}
