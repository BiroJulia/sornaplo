import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';


class LogPopUpEdit extends StatefulWidget {
  final MapEntry<String, dynamic> type;
  final Future<bool> Function(String, String, DateTime, File?) onSave;

  const LogPopUpEdit({Key? key, required this.type, required this.onSave})
      : super(key: key);

  @override
  State<LogPopUpEdit> createState() => _LogPopUpEditState();
}

class _LogPopUpEditState extends State<LogPopUpEdit> {
  String descriptionText = "";
  bool isError = false;
  DateTime initialDate = DateTime.now();
  File? _image; // Kép változó

  final dateForm = DateFormat('dd-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) {
      setState(() {
        initialDate = picked;
      });
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

// Future<bool> saveLogs(
//     String type,
//     String description,
//     DateTime selectedDate
//     ) async {
//
//   List<Map<String, dynamic>> logs = [];
//
//   if (widget.beer['logs'] != null) {
//     for (final element in widget.beer['logs']) {
//       logs.add(element as Map<String, dynamic>);
//     }
//   }
//
//   logs.add({
//     type: {'description': description, 'date': selectedDate}
//   });
//   await _firestore
//       .collection('brews')
//       .doc(widget.beerId)
//       .update({'logs': logs});
//   widget.beer['logs'] = logs;
//   setState(() {});
//   return true;
// }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: FractionallySizedBox(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Mégsem',
                          style: TextStyle(color: Colors.black),
                        )),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          if (descriptionText.isEmpty) {
                            setState(() {
                              isError = true;
                            });
                            return;
                          }
                          widget
                              .onSave(
                                  widget.type.key, descriptionText, initialDate,_image)
                              .then((value) => {
                                    if (value)
                                      {
                                        Navigator.of(context).pop(),
                                        Navigator.of(context).pop()
                                      }
                                  });
                        },
                        child: const Text(
                          'Mentés',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 140, 140, 140),
                      size: 30,
                    ),
                    TextButton(
                        onPressed: () => {_selectDate(context)},
                        child: Text(
                          dateForm.format(initialDate),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 140, 140, 140),
                              fontSize: 19),
                        ))
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      widget.type.value,
                      color: const Color.fromARGB(255, 140, 140, 140),
                      size: 30,
                    ),
                    Text(
                      widget.type.key,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 140, 140, 140),
                          fontSize: 19
                      ),
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 300,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    onChanged: (newValue) {
                      setState(() {
                        isError = false;
                        descriptionText = newValue;
                      });
                    },
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: (!isError) ? Colors.black : Colors.red,
                              width: 1,
                          ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add space below the text field
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: 100,
                    height: 100,
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : Icon(Icons.add, size: 50, color: Colors.grey),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
