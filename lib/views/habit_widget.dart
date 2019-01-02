import 'package:flutter/material.dart';
import "package:habits/models/habit.dart";

class HabitWidget extends StatefulWidget {
  final Habit habit;
  final Function removeHabit;

  HabitWidget(this.habit, this.removeHabit);
  @override
  State<StatefulWidget> createState()=> _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {

  final renameController = TextEditingController(text:"");


  void _showRenameDialog(BuildContext context) async {
    renameController.text = widget.habit.name;
    String name = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Rename Habit "),//${widget.habit.name}"),
            content: TextFormField(
              decoration: InputDecoration(
              labelText: 'New Name',
            ),
              controller: renameController,
            ),

            actions: <Widget>[

              FlatButton(
                color: Colors.red,
                child: Text("Cancel", style: TextStyle(color:Colors.white)),
                onPressed: (){
                  Navigator.of(context).pop(widget.habit.name);
                },
              ),

              new FlatButton(
                  color: Colors.black12,
                  child: Text("Confirm", style: TextStyle(color: Colors.black)),
                  onPressed: (){
                    Navigator.of(context).pop(renameController.text);

                  }
              ),

            ],
          );
        }
    );
    name = name != null ? name : widget.habit.name;
    setState((){
      widget.habit.name = name;
    });
  }
  void _showRipDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Reset Inquired Progress?"),//${widget.habit.name}"),
            content: Text("Are you sure you want to reset day counter for ${widget.habit.name} ?"),


            actions: <Widget>[
              FlatButton(
                color: Colors.black12,
                child: Text("Cancel", style: TextStyle(color:Colors.black)),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),

              new FlatButton(
                  color: Colors.red,
                  child: Text("Reset", style: TextStyle(color: Colors.white)),
                  onPressed: (){
                    widget.habit.resetStreak();
                    Navigator.of(context).pop();
                  }
              ),

            ],
          );
        }
    );
    setState(() {});
  }
  void _showDeleteDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Habit?"),//${widget.habit.name}"),
            content: Text("Are you sure you want to Delete ${widget.habit.name} ?"),

            actions: <Widget>[
              FlatButton(
                color: Colors.black12,
                child: Text("Cancel", style: TextStyle(color:Colors.black)),
                onPressed: () => Navigator.of(context).pop()
              ),

              new FlatButton(
                  color: Colors.red,
                  child: Text("Delete", style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    widget.removeHabit(widget.habit);
                    Navigator.of(context).pop();
                  }
              ),

            ],
          );
        }
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      title: Text(widget.habit.name, textScaleFactor: 1.5,),
      leading: Text(widget.habit.streak.toString() + " Days"),
      trailing: RaisedButton(
          color: Colors.red,
          child:Text("RIP", style: TextStyle(color: Colors.white),),
          onPressed: () => _showRipDialog(context)
      ),

      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(flex:4, child: RaisedButton(
                  child:Text("Rename", style:TextStyle(color:Colors.white)),
                  color: Colors.green,
                  onPressed: () => _showRenameDialog(context)
              )),

              Spacer(),
              Expanded(flex:4, child: RaisedButton(
                  child:Text("Delete", style:TextStyle(color:Colors.white)),
                  color: Colors.red,
                  onPressed: () => _showDeleteDialog(context))
              ),

            ],
          ),
        )
      ],
    );
  }

}