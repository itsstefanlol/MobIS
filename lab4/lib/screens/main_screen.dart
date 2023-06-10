import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab4/model/exam_item.dart';
import 'package:lab4/screens/calendar.dart';
import 'package:lab4/screens/exam_detail_screen.dart';
import 'package:nanoid/nanoid.dart';

class MainScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final String title = "Exam organizer";

  List<ExamItem> _examItems = [
    ExamItem(id: nanoid(5), naslov: "Programiranje na video igri i specijalni efekti", datum: DateTime.parse('2022-01-10 10:00')),
    ExamItem(id: nanoid(5), naslov: "Metodologija na istrazuvanjeto vo IKT", datum: DateTime.parse('2022-02-04 15:00')),
    ExamItem(id: nanoid(5), naslov: "Psihologija na ucilisna vozrast", datum: DateTime.parse('2022-04-05 09:00')),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void addItemToList(){
    if (nameController.text.isEmpty)
    {
      return;
    }
    setState(() {
      ExamItem newItem = ExamItem(
          id: nanoid(5),
          naslov: nameController.text,
          datum: DateTime.parse(dateController.text),
      );
      nameController.text = "";
      dateController.text = "";
      _examItems.add(newItem);
      Navigator.pop(context);
    });
  }

  void deleteItem(String id){
    setState(() {
      _examItems.removeWhere((element) => element.id == id);
    });
  }

  void ShowDetails(BuildContext context, ExamItem item){
     /* Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ExamDetailScreen(item)),
      );*/
    Navigator.of(context).pushNamed(
      ExamDetailScreen.routeName,
      arguments: item
    );
  }

  void ShowCalendar(BuildContext context, List<ExamItem> items){
    Navigator.of(context).pushNamed(
      CalendarScreen.routeName,
        arguments: items
    );
  }

  Widget createBody(){
    return Column(
      children: [
        Expanded(
            child: _examItems.isEmpty ?
            Center(child: Text(
                "No exams",
                style: const TextStyle(fontWeight: FontWeight.bold)
            )
              ,) :
            ListView.builder(
              itemCount: _examItems.length,
              itemBuilder: (context, index){
                print(_examItems[index]);
                return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      title: Text(
                          _examItems[index].naslov,
                          style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      subtitle: Text(_examItems[index].datum.toString()),
                      onTap: () => ShowDetails(context, _examItems[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteItem(_examItems[index].id),
                      ),
                    )
                );
              },
            )
        ),

      ],
    );
  }

  PreferredSizeWidget createAppBar(){
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(onPressed: () {
          showDialog(context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 20
                  ),
                  title: Row(
                    children: [
                      Text("Dodadi ispit"),
                      Spacer(),
                      IconButton(onPressed: () {Navigator.pop(context);},
                          icon: Icon(Icons.cancel))
                    ],
                  ),
                  children: [
                    Divider(height: 5,indent: 5),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Ime na predmet",
                      ),
                    ),
                    TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        hintText: "Datum i vreme",
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    Divider(height: 5,indent: 5),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        child: Text("Dodadi"),
                        onPressed: (){
                          addItemToList();
                        },
                      ),
                    )
                  ],
                );  });
        } ,
          icon: Icon(Icons.add, size: 35),
          padding: EdgeInsets.only(right: 40),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: createAppBar(),
        body: createBody(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => ShowCalendar(context, _examItems),
            tooltip: 'Calendar',
            child: const Icon(Icons.calendar_today),
        ),
    );
  }

}