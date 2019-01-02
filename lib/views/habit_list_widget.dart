import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/views/habit_widget.dart';

class HabitList extends StatefulWidget {
  final List<Habit> habits;
  final String title;
  final Function removeHabit;

  HabitList({this.habits = const [], this.title= "Habit Name", this.removeHabit});
  @override
  State<StatefulWidget> createState()=> HabitListState();

}


class HabitListState extends State<HabitList> {

  Widget _getWidgetList() {
    List<HabitWidget> widgets = new List();
    for (Habit habit in widget.habits)
      widgets.add(HabitWidget(habit, widget.removeHabit));

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