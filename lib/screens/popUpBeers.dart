import 'package:flutter/material.dart';

class PopUpBeers extends StatelessWidget {
  final List<String> beerlist;
  final void Function(String) onPressed;
  const PopUpBeers({
    Key? key,
    required this.beerlist,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Megsem")),
                Spacer(),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: beerlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      onPressed(beerlist[index]);
                      Navigator.of(context).pop(); // close the popup menu
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          beerlist[index],
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
