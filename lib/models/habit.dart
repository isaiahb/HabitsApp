import 'dart:convert';
class Habit {
  DateTime dateCreated;
  DateTime lastReset;
  List<dynamic> resetDates; //should be a string, but json lib can only decode list as dynamic
  String name;

  List<DateTime> get resetDateTimeList {
    List<DateTime> list = new List();
    for (String date in resetDates) {
      list.add(DateTime.parse(date));
    }
    return list;
  }

  Habit(this.name, { this.dateCreated, this.lastReset, this.resetDates}) {
    DateTime now = DateTime.now();
    this.dateCreated = dateCreated != null ? dateCreated : now;
    this.lastReset = lastReset != null ? lastReset : now;
    this.resetDates = resetDates != null ? resetDates : List<dynamic>();
    this.resetDates.add(now.toIso8601String());
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return new Habit(map["name"], dateCreated: DateTime.parse(map["dateCreated"]), lastReset: DateTime.parse(map["lastReset"]), resetDates: map["resetDates"]);
  }

  factory Habit.fromJson(String json) {
    Map<String, dynamic> map;
    map = jsonDecode(json);
    return Habit.fromMap(map);
  }

  Map<String, dynamic> getMap() {
    return {
      "name": name,
      "dateCreated":  dateCreated.toIso8601String(),
      "lastReset":    lastReset.toIso8601String(),
      "resetDates":   resetDates
    };
  }

  String toJson() {
    Map<String, dynamic> map = getMap();
    return jsonEncode(map);
  }

  int get streak => lastReset.difference(DateTime.now()).inDays;

  void resetStreak(){
    lastReset = DateTime.now();
    resetDates.add(lastReset.toIso8601String());
  }

}


