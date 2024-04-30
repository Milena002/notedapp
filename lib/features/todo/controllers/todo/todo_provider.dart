
import 'dart:math';

import 'package:notedapp/common/helpers/db_helper.dart';
import 'package:notedapp/common/models/task.dart';
import 'package:notedapp/common/utils/constants.dart';
//import 'package:pinput/pinput.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<Task>build(){
    return [];

  }

  void refresh () async{
    final data = await DBHelper.getItems();
   state = data.map((e) => Task.fromJson(e)).toList();

   void addItem (Task task) async {
    await DBHelper.createItem(task);
    refresh();
   }

     void updateItem (int id, String title, String desc, int isCompleted, String date, String startTime, String endTime) async {
    await DBHelper.updateItem(id,title, desc,isCompleted,  date, startTime, endTime);
    refresh();
   }

    Future <void> deleteTodo (int id) async {
    await DBHelper.deleteItem(id);
    refresh();
   }


     void markAsCompleted (int id, String title, String desc, int isCompleted, String date, String startTime, String endTime) async {
    await DBHelper.updateItem(id,title, desc, 1 ,  date, startTime, endTime);
    refresh();
  }
//today
  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0,10);
  }

  //tommorow
  String getTomorrow() {
    DateTime tommorow = DateTime.now().add(Duration(days: 1));
    return tommorow.toString().substring(0,10);
  }

  List <String> last30days(){
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30 ; i++) {
      DateTime date = oneMonthAgo.add( Duration(days: i));
      dates.add(date.toString().substring(0,10));
    }
     return dates; 
  }


  bool getStatus(Task data) {
    bool? isCompleted;
    if (data.isCompleted == 0) {
      isCompleted = false;
     }else{
      isCompleted = true;
     }
     return isCompleted;
  }
}

  String getToday() {
     DateTime today = DateTime.now();
    return today.toString().substring(0,10);
  }

  void addItem(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  dynamic getRandomColor(){
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  bool getStatus(Task data) {
     bool? isCompleted;
    if (data.isCompleted == 0) {
      isCompleted = false;
     }else{
      isCompleted = true;
     }
     return isCompleted;
  }

  void deleteTodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
   }

  String getTomorrow() {
     DateTime tommorow = DateTime.now().add(const Duration(days: 1));
    return tommorow.toString().substring(0,10);

  }

    String getDayAfter() {
     DateTime tommorow = DateTime.now().add(const Duration(days: 2 ));
    return tommorow.toString().substring(0,10);

  }

  List last30days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30 ; i++) {
      DateTime date = oneMonthAgo.add( Duration(days: i));
      dates.add(date.toString().substring(0,10));
    }
     return dates;
  }

  void markAsCompleted(int id, String title, String desc, int isCompleted, String date, String startTime, String endTime) async {
    await DBHelper.updateItem(id,title, desc, 1 ,  date, startTime, endTime);
    refresh();
  }

  void updateItem(int id, String title, String desc, int isCompleted, String date, String startTime, String endTime) async {
    await DBHelper.updateItem(id,title, desc,isCompleted,  date, startTime, endTime);
    refresh();
  }
}
