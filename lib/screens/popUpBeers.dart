import 'package:flutter/material.dart';

class PopUpBeers extends StatelessWidget {
  final List<String> beerlist;
  final void Function(String) onPressed;
  const PopUpBeers(
      {super.key, required this.beerlist, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: beerlist.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return InkWell(
        //         onTap: () {
        //           onPressed(beerlist[index]);
        //           Navigator.of(context).pop(); // close the popup menu
        //         },
        //         child: Center(
        //           child: Text(beerlist[index]),
        //         ),
        //       );
        //     },
        //   ),
        // )
      ],
    ));
  }
}
