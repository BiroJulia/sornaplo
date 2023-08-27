import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sornaplo/utils/colors_utils.dart';
import 'package:sornaplo/utils/logPopUpEdit.dart';

class LogScreen extends StatefulWidget {
  final String beerId;
  final Map<String, dynamic> beer;

  const LogScreen({Key? key, required this.beer, required this.beerId})
      : super(key: key);

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final dateForm = new DateFormat('dd-MM-yyyy');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, dynamic> actionList = {
    'Főzés': Icons.soup_kitchen,
    'Hideg komlózás': Icons.grass,
    'Palackozás': Icons.local_drink,
    'Bejegyzés': Icons.draw
  };

  Future<bool> saveLogs(
      String type, String description, DateTime selectedDate) async {

    List<Map<String, dynamic>> logs = [];

    if (widget.beer['logs'] != null) {
      for (final element in widget.beer['logs']) {
        logs.add(element as Map<String, dynamic>);
      }
    }

    logs.add({
      type: {'description': description, 'date': selectedDate}
    });
    await _firestore
        .collection('brews')
        .doc(widget.beerId)
        .update({'logs': logs});
    widget.beer['logs'] = logs;
    setState(() {});
    return true;
  }

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
          ? ListView.builder(
              itemCount: widget.beer['logs'].length,
              itemBuilder: (context, index) {
                final logs = widget.beer['logs'][index].entries.first as MapEntry<String, dynamic>;
                final dynamic date = logs.value['date'];
                DateTime dateTime = DateTime.now();
                // log(date.runtimeType.toString());
                if (date.runtimeType == Timestamp) {
                  dateTime = date.toDate();
                } else {
                  dateTime = date;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            dateForm.format(dateTime),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 140, 140, 140),
                                fontSize: 19),
                          ),
                          const Spacer(),
                          Icon(actionList[logs.key])
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade200,
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        child: Text(logs.value['description']),
                      )
                    ],
                  ),
                );
              })
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
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) {
                              return LogPopUpEdit(
                                type: actionList.entries.elementAt(index),
                                onSave: saveLogs,
                              );
                            });
                      },
                      child: Text(
                        actionList.keys.elementAt(index),
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
