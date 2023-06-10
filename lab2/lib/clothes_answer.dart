import 'package:flutter/material.dart';

class ClothesAnswer extends StatelessWidget {
  String answerText;
  VoidCallback tapped;
  ClothesAnswer(this.tapped, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        child: Text(
          answerText,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 138, 25, 17),
          ),
        ),
        onPressed: tapped,
        style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 132, 220, 135),
            padding: const EdgeInsets.all(15),
            minimumSize: Size(300, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }
}
