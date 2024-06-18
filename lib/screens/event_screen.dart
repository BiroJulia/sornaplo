import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sornaplo/screens/public_recipes_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sornaplo/utils/colors_utils.dart';

import '../utils/utils.dart';
import 'brewing_process.dart';
import 'event_details_screen.dart';
import 'home_screen.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final _eventNameController = TextEditingController();
  final _eventTimeController = TextEditingController();
  final _eventLocationController = TextEditingController();
  final _eventDescriptionController = TextEditingController();
  Map<DateTime, List> _events = {};

  @override
  void initState() {
    super.initState();
    _loadFirestoreEvents();
  }

  Future<void> _loadFirestoreEvents() async {
    FirebaseFirestore.instance.collection('events').snapshots().listen((snapshot) {
      setState(() {
        _events = {};
        for (var doc in snapshot.docs) {
          DateTime eventDate = (doc['date'] as Timestamp).toDate();
          DateTime eventDateKey = DateTime(eventDate.year, eventDate.month, eventDate.day);
          if (_events[eventDateKey] == null) {
            _events[eventDateKey] = [];
          }
          _events[eventDateKey]!.add(doc);
        }
      });
    });
  }

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) {
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
              onPressed: () {
                FirebaseFirestore.instance.collection('events').add({
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: hexStringToColor("EC9D00"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addEvent,
          ),
        ],
        title: Text('Események'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(50, 10, 140, 50),
              decoration: BoxDecoration(
                color: hexStringToColor("EC9D00"),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Sörnapló',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Recipes'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PublicRecipesScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_pin_rounded),
                    title: Text('Profil'),
                    onTap: () {
                      // profil
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.scatter_plot_outlined),
                    title: Text('Sörfőzés folyamata'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BrewingProcessScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today_outlined),
                    title: Text('Esemény naptár'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Kijelentkezés'),
              leading: Icon(Icons.logout),
              onTap: () {
                showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: _buildEventsMarker(day, events),
                  );
                }
                return Container();
              },
            ),
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('events')
                  .where('date', isEqualTo: _selectedDay)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var events = snapshot.data!.docs;
                if (events.isEmpty) {
                  return Center(child: Text('Nincs esemény erre a napra'));
                }
                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    var event = events[index];
                    return ListTile(
                      title: Text(event['name']),
                      subtitle: Text('${event['time']} - ${event['location']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(
                              eventId: event.id,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime day, List events) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    );
  }
}
