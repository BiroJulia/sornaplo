import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sornaplo/screens/popUpEdit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _brewStream;
  final List<Map<String, dynamic>> savedBrewCards = [];

  String _getMonth(int month) {
    List<String> months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month];
  }

  void addBrew(Map<String, dynamic> brew) {
    setState(() {
      savedBrewCards.add(brew);
    });
    _firestore.collection('brews').add({
      'name': brew['name'],
      'date': brew['date'],
      'type': brew['type'],
      'rating': brew['rating'],
    });
  }

  @override
  void initState() {
    super.initState();
    _brewStream = Stream<QuerySnapshot>.empty();
    _fetchBrews();
  }

  Future<void> _fetchBrews() async {
    _brewStream = _firestore.collection('brews').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sornaplo"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return popUpEdit(
                    onSave: addBrew,
                  );
                },
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _brewStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> brewCards = [];

          for (var doc in snapshot.data!.docs) {
            var brewData = doc.data() as Map<String, dynamic>;
            brewCards.add(
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brewData["name"],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _getMonth(brewData["date"].toDate().month),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromARGB(255, 101, 101, 101),
                              ),
                            ),
                            Text(
                              "${brewData["date"].toDate().day}",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 101, 101, 101),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            brewData["type"],
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: brewData["rating"].toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24,
                            itemPadding: EdgeInsets.symmetric(vertical: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              _firestore
                                  .collection('brews')
                                  .doc(doc.id)
                                  .update({'rating': rating});
                            },
                          ),
                          SizedBox(width: 8),
                          brewData["rating"] > 2.5
                              ? Icon(Icons.thumb_up, color: Colors.green)
                              : Icon(Icons.thumb_down, color: Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return savedBrewCards.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/smallbeericon.png",
                        width: 100,
                        height: 100,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        child: Text(
                          "Üdvözlet a Sörnaplóban! \n\n Hogy ez az oldal ne legyen ilyen üres, főzz egy új sört és vezess itt naplót.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView(
                  children: brewCards,
                );
        },
      ),
    );
  }
}



      //     Center(
      //   child: ElevatedButton(
      //     child: Text("Logout"),
      //     onPressed: () {
      //       FirebaseAuth.instance.signOut().then((value) {
      //         print("Signed Out");
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => SignInScreen()));
      //       });
      //     },
      //   ),
      // ),