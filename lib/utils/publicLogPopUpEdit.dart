import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicLogPopUpEdit extends StatefulWidget {
  final MapEntry<String, dynamic> type;
  final Future<bool> Function(String, String, File?) onSave;

  const PublicLogPopUpEdit({Key? key, required this.type, required this.onSave})
      : super(key: key);

  @override
  State<PublicLogPopUpEdit> createState() => _PublicLogPopUpEditState();
}

class _PublicLogPopUpEditState extends State<PublicLogPopUpEdit> {
  String descriptionText = "";
  bool isError = false;
  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
                        onPressed: () async {
                          if (descriptionText.isEmpty) {
                            setState(() {
                              isError = true;
                            });
                            return;
                          }
                          try {
                            final success = await widget.onSave(widget.type.key, descriptionText, _image);
                            if (success) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                          } catch (e) {
                            print('Error saving recipe: $e');
                          }
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
                    Icon(
                      widget.type.value,
                      color: const Color.fromARGB(255, 140, 140, 140),
                      size: 30,
                    ),
                    Text(
                      widget.type.key,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 140, 140, 140),
                          fontSize: 19),
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
                const SizedBox(height: 20),
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
