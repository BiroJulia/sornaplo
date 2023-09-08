import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogPopUpEdit extends StatefulWidget {
  final MapEntry<String, dynamic> type;
  final Future<bool> Function(String, String, DateTime) onSave;

  const LogPopUpEdit({Key? key, required this.type, required this.onSave})
      : super(key: key);

  @override
  State<LogPopUpEdit> createState() => _LogPopUpEditState();
}

class _LogPopUpEditState extends State<LogPopUpEdit> {
  String descriptionText = "";
  bool isError = false;
  DateTime initialDate = DateTime.now();
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
                                  widget.type.key, descriptionText, initialDate)
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
                              width: 1)),
                    ),
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
