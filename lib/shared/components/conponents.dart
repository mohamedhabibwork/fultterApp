import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/shared/Cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController inputController,
  required TextInputType keyboardType,
  required String labelText,
  required Function validate,
  required IconData prefix,
  Function? onChange,
  Function? onSubmit,
  Function? onTap,
  Function? onPressSuffixIcon,
  bool IsPressSuffixIcon = false,
  bool IsUpperCase = true,
  double radius = 3.0,
  bool IsPassword = false,
  bool IsClickable = true,
  IconData? suffix,
}) =>
    TextFormField(
      controller: inputController,
      keyboardType: keyboardType,
      enabled: IsClickable,
      obscureText: IsPassword,
      onChanged: (value) => (onChange != null) ? onChange(value) : null,
      onFieldSubmitted: (value) {
        if (onSubmit != null) onSubmit(value);
      },
      onTap: () => onTap != null ? onTap() : null,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: prefix is IconData ? Icon(prefix) : null,
        suffixIcon: suffix != null
            ? (IsPressSuffixIcon
                ? IconButton(
                    onPressed: () =>
                        onPressSuffixIcon != null ? onPressSuffixIcon() : null,
                    icon: Icon(suffix))
                : Icon(suffix))
            : null,
      ),
      validator: (value) => validate(value),
    );

Widget defaultButton({
  required BuildContext context,
  double width = double.infinity,
  double? height,
  Color? background,
  required Function function,
  required String text,
}) =>
    // ignore: sized_box_for_whitespace
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () => function(),
      ),
    );

Widget BuildTaskItem(BuildContext context,task) {
  return Dismissible(
    key: Key(task['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(task['time']),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  task['date'],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(onPressed: (){AppCubit.get(context).updateTaskStatus(task['id'], "done");}, icon: Icon(Icons.check_box_rounded),color: Theme.of(context).primaryColor,),
          IconButton(onPressed: (){AppCubit.get(context).updateTaskStatus(task['id'], "archive");}, icon: Icon(Icons.archive_outlined),color: Theme.of(context).primaryColor,),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteToTable(task['id']);
    },
  );
}

Widget tasksBuilder({required List<Map> tasks}){
  return tasks.length > 0? ListView.separated(
      itemBuilder: (context, index) => BuildTaskItem(context,tasks[index]),
      separatorBuilder: (context, index) =>
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
      itemCount: tasks.length)
      : Center(child: Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.menu,size: 100,color: Colors.grey,),
      Container(
        child: Text("No Tasks yet, Please Enter One",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey
        ),),
      ),
    ],
  ));
}