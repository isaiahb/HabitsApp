import 'package:flutter/material.dart';
import "package:habits/models/habit.dart";

class HabitWidget extends StatefulWidget {
  final Habit habit;
  HabitWidget(this.habit);
  @override
  State<StatefulWidget> createState()=> _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {

  void _onEditPressed() => print("editting");
  void _onDeletePressed() => print("deleting");

  Widget _getTrailing() {
    return Container(
      child: Row(children: <Widget>[
        RaisedButton(child: Text("Edit"), color: Colors.green, onPressed: _onEditPressed),
        RaisedButton(child: Text("Delete"), color: Colors.red, onPressed: _onDeletePressed),

      ]),
    );
  }

  void _resetDate(){}
  void _delete(){}
  final renameController = TextEditingController(text:"");

  void _rename() {
    print(renameController.text);
  }

  void _showRenameDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Rename - ${widget.habit.name}"),
            content: TextField(
              controller: renameController,
            ),

            actions: <Widget>[
              new FlatButton(
                  child: Text("Confirm", style: TextStyle(color:Colors.green)),
                  onPressed: (){
                    _rename();
                  }
              ),

              FlatButton(
                color: Colors.red,
                child: Text("Cancel", style: TextStyle(color:Colors.white)),
                onPressed: (){print("cancel");},
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      title: Text(widget.habit.name, textScaleFactor: 1.5,),
      leading: Text(widget.habit.streak.toString() + " Days"),
      trailing: RaisedButton(
          color: Colors.red,
          child:Text("RIP", style: TextStyle(color: Colors.white),),
          onPressed: ()=>print("Rip")
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
                  onPressed: ()=> _showRenameDialog(context)
              )),

              Spacer(),
              Expanded(flex:4, child: RaisedButton(
                  child:Text("Delete", style:TextStyle(color:Colors.white)),
                  color: Colors.red,
                  onPressed: _onDeletePressed)
              ),

            ],
          ),
        )
      ],
    );
  }

}