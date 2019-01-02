import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/views/habit_list_widget.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Good Habits',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new MyHomePage(title: 'Habits'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  final _textOptions = ['Good Habits', 'Bad Habits'];

  List<List<Habit>> _habitsOptions = [List<Habit>(), List<Habit>()];
  List<Habit> get goodHabits => _habitsOptions[0];
  List<Habit> get badHabits => _habitsOptions[1];
  List<Habit> get habits => _habitsOptions[_selectedIndex];
  String get title => _textOptions[_selectedIndex];

  String _goodHabitsString() {
    List<String> strings = new List();
    for (Habit habit in goodHabits)
      strings.add(habit.toJson());
    return jsonEncode(strings);
  }

  String _badHabitsString() {
    List<String> strings = new List();
    for (Habit habit in badHabits)
      strings.add(habit.toJson());
    return jsonEncode(strings);
  }

  List<Habit> _habitListFromJson(String json) {
    List<Habit> habits = new List();
    List<dynamic> dynamicList = jsonDecode(json);
    for (String habitJson in dynamicList)
      habits.add(Habit.fromJson(habitJson));
    return habits;
  }


  TextEditingController nameController = TextEditingController();

  void _onTap(int index) {setState(() => _selectedIndex = index);}
  void _removeHabit(Habit habit) {setState(() => habits.remove(habit));}

  void _createHabit(BuildContext context) async {
    Habit habit = await showDialog<Habit>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Habit'),

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter habit name',
                ),

              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    onPressed: () { Navigator.pop(context, null); },
                    child: const Text('Cancel'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    onPressed: () { Navigator.pop(context, Habit(nameController.text, good: _selectedIndex == 0)); },
                    child: const Text('Add', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )

          ],
        );
      }
    );
    if (habit == null) return;

    setState(() => habits.add(habit));
    print("GOOD: " + _habitListFromJson(_goodHabitsString()).toString());
    print("BAD: " + _badHabitsString());
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text(title),
      ),


      body: new Center(
        child: HabitList(title: title, habits: habits, removeHabit: _removeHabit)
      ),


      floatingActionButton: new FloatingActionButton(
        onPressed: (){_createHabit(context);},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Good Habits')
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.block),
              title: Text('Bad Habits')
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked

    );
  }

}




