import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EventDetailsScreen extends StatelessWidget {
  final String eventId;

  EventDetailsScreen({required this.eventId});

  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esemény Részletek'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('events').doc(eventId).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              var event = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event!['name'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Időpont: ${event['time']}'),
                    SizedBox(height: 8),
                    Text('Helyszín: ${event['location']}'),
                    SizedBox(height: 8),
                    Text('Leírás: ${event['description']}'),
                    SizedBox(height: 16),
                    Text('Kommentek:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('events').doc(eventId).collection('comments').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var comments = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return ListTile(
                      title: Text(comment['text']),
                      subtitle: Text(comment['user']),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(labelText: 'Komment'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    FirebaseFirestore.instance.collection('events').doc(eventId).collection('comments').add({
                      'text': _commentController.text,
                      'user': 'Anonim',
                    });
                    _commentController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
