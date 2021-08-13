import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/Cubit/cubit.dart';
import 'package:todo/shared/Cubit/states.dart';
import 'package:todo/shared/components/conponents.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

// create database
// create tables
// open database
// insert to table
// update to table
// select to table
// delete to table
class _HomeLayoutState extends State<HomeLayout> {
  final TextEditingController __title = TextEditingController();
  final TextEditingController __date = TextEditingController();
  final TextEditingController __time = TextEditingController();
  final TextEditingController __status = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.IsBottomSheetShow ? Icons.edit : Icons.add),
              onPressed: () {
                if (cubit.IsBottomSheetShow) {
                  if (formKey.currentState!.validate()) {
                    cubit
                        .insertToTable(__title.text, __date.text, __time.text,
                            __status.text)
                        .then((insertValue) => Navigator.pop(context));
                    formKey.currentState!.reset();
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                          (context) => Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      defaultFormField(
                                          inputController: __title,
                                          keyboardType: TextInputType.text,
                                          labelText:
                                              "Title",
                                          validate: (String value) =>
                                              value.isEmpty
                                                  ? ' title empty '
                                                  : null,
                                          prefix: Icons.title),
                                      const SizedBox(height: 20),
                                      defaultFormField(
                                          inputController: __time,
                                          keyboardType: TextInputType.datetime,
                                          labelText: "Time",
                                          onTap: () {
                                            print("object");
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              if (value == null) return value;
                                              __time.text = value
                                                  .format(context)
                                                  .toString();
                                            });
                                          },
                                          validate: (String value) =>
                                              value.isEmpty
                                                  ? ' Time empty '
                                                  : null,
                                          prefix: Icons.title),
                                      const SizedBox(height: 20),
                                      defaultFormField(
                                          inputController: __date,
                                          keyboardType: TextInputType.datetime,
                                          labelText: "Date",
                                          onTap: () {
                                            print("object Date");
                                            showDatePicker(
                                                    context: context,
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now()
                                                        .add(
                                                            Duration(days: 30)),
                                                    initialDate: DateTime.now())
                                                .then((value) {
                                              if (value == null) return value;
                                              __date.text = DateFormat.yMMMd()
                                                  .format(value)
                                                  .toString();
                                            });
                                          },
                                          validate: (String value) =>
                                              value.isEmpty
                                                  ? ' Date empty '
                                                  : null,
                                          prefix: Icons.title),
                                    ],
                                  ),
                                ),
                              ),
                          elevation: 20.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetShowState(false);
                  });
                  cubit.changeBottomSheetShowState(true);
                }
                // cubit.changeBottomSheetShowState(!cubit.IsBottomSheetShow);
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (int value) {
                cubit.changeIndex(value);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: "Done"),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.archive_outlined), label: "Archive"),
              ],
            ),
            body: state is! AppLoaderState
                ? cubit.screens[cubit.currentIndex]
                : Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )),
          );
        },
      ),
    );
  }
}
