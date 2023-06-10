import 'package:flutter/material.dart';
import './clothes_question.dart';
import './clothes_answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void _iWasTapped() {
    setState(() {
      _questionIndex += 1;
    });
    print('I was tapped');
  }

  var questions = [
    {
      'question': "Select type of shirt",
      'answer': [
        'Flannel',
        'Office',
        'Classical',
        'Aloha',
      ]
    },
    {
      'question': "Select material",
      'answer': [
        'Leather',
        'Denim',
        'Cotton',
        'Linen',
      ]
    },
    {
      'question': "Select color",
      'answer': [
        'Navy',
        'White',
        'Grey',
        'Black',
        'Beige',
        'Red',
        'Green',
        'Creme',
      ]
    },
  ];
  var _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Laboratoriska 2",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Laboratoriska 2"),
        ),
        body: Column(
          children: [
            ClothesQuestion(questions[_questionIndex]['question'].toString()),
            ...(questions[_questionIndex]['answer'] as List<String>)
                .map((answer) {
              return ClothesAnswer(_iWasTapped, answer);
            }),
          ],
        ),
      ),
    );
  }
}
