import 'package:flutter/material.dart';
import "models/habit.dart";
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  final _textOptions = [
    ('Good Habits'),
    ('Bad Habits')
  ];
  final _colorOptions = [
    Colors.blue,
    Colors.deepOrange,
  ];
  final _habitsOptions = [
    List<Habit>(),
    List<Habit>()
  ];

  List<Habit> get habits => _habitsOptions[_selectedIndex];
  Color get color => _colorOptions[_selectedIndex];
  String get title => _textOptions[_selectedIndex];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _createHabit({String name = "Habit Name"}) {
    setState(() {
      Habit habit = new Habit(name);
      habits.add(habit);
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text(title),
      ),


      body: new Center(
        child: HabitList(title: title, habits: habits)
      ),


      floatingActionButton: new FloatingActionButton(
        onPressed: _createHabit,
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


class HabitList extends StatefulWidget {
  List<Habit> habits;
  final String title;


  HabitList({this.habits = const [], this.title= "Habit Name"});

  @override
  State<StatefulWidget> createState()=> HabitListState();

}


class HabitListState extends State<HabitList> {

  Widget _getWidgetList() {

    List<HabitWidget> widgets = new List();

    for (Habit habit in widget.habits)
      widgets.add(HabitWidget(habit));

    print("got here");

    return ListView(
      children: widgets,
      shrinkWrap: true,
    );

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text(widget.title, style: Theme.of(context).textTheme.display1),
          new Text("Total habits : ${widget.habits.length}"),
          Container(child: _getWidgetList()),
        ],
      )
    );
  }

}


class HabitWidget extends StatefulWidget {
  final Habit habit;
  HabitWidget(this.habit);
  @override
  State<StatefulWidget> createState()=> _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: Text(widget.habit.name),
      subtitle: Text(widget.habit.streak.toString() + " Days"),

    );
  }

}