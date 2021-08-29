import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived_tasks/archived_task_screen.dart';
import 'package:todo/modules/done_tasks/done_task_screen.dart';
import 'package:todo/modules/new_tasks/new_task_screen.dart';
import 'package:todo/shared/Cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool IsBottomSheetShow = false;

  // late List<Map> tasks = [];
  late List<Map> newTasks = [];
  late List<Map> archiveTasks = [];
  late List<Map> doneTasks = [];

  final List<String> titles = [
    "New Task",
    "Done Task",
    "Archive Task",
  ];

  final List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchiveTaskScreen(),
  ];

  late final Database _database;

  void createDatabase() async {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        print('created as  version:${version}');
        await db.execute('CREATE TABLE tasks ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT,'
            'date TEXT,'
            'time TEXT,'
            'status TEXT'
            ');');
      },
      onOpen: (db) async {
        print('Opened');
      },
    ).then((value) {
      _database = value;
      emit(AppCreateDatabaseState());
      getTasks();
    });
  }

  Future insertToTable(String title, String date, String time, String status) {
    return _database.transaction((txn) {
      return txn.insert('tasks', {
        "title": title,
        "date": date,
        "time": time,
        "status": "new"
      }).then((value) {
        changeBottomSheetShowState(false);
        emit(AppInsertTaskState());
        getTasks();
      });
    });
  }

  Future updateToTable(int id) async {
    return await _database.transaction((txn) async {
      return txn
          .update(
              'tasks',
              {
                "title": "__title.text",
                "date": "__date.text",
                "time": "__time.text",
                "status": "new"
              },
              where: "id = ?",
              whereArgs: [id])
          .then((value) {
        changeBottomSheetShowState(false);
        emit(AppUpdateTaskState());
        getTasks();
      });
    });
  }

  Future deleteToTable(int id) async {
    return await _database.transaction((txn) async {
      return txn
          .delete('tasks', where: "id = ?", whereArgs: [id]).then((value) {
        emit(AppDeleteTaskState());
        getTasks();
      });
    });
  }

  void getTasks() {
    emit(AppLoaderState());
    _database.query('tasks').then((value) {
      newTasks = value.where((element) => element['status'] == "new").toList();
      doneTasks = value.where((element) => element['status'] == "done").toList();
      archiveTasks = value.where((element) => element['status'] == "archive").toList();
      print(value);
      emit(AppGetTaskState());
    });
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void updateTaskStatus(int id,String status) async{
    await _database.transaction((txn) {
      return txn
          .update(
          'tasks',
          {
            "status": status
          },
          where: "id = ?",
          whereArgs: [id])
          .then((value) {
        changeBottomSheetShowState(false);
        emit(AppUpdateTaskState());
        getTasks();
      });
    });
  }
  void changeBottomSheetShowState(bool show) {
    IsBottomSheetShow = show;
    emit(AppChangeBottomSheetShowState());
  }
}
