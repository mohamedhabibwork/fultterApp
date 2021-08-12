import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'habib', phone: '+22132131456464'),
    UserModel(id: 2, name: 'mohamed', phone: '+34654646464'),
    UserModel(id: 3, name: 'ahmed', phone: '+389464646'),
    UserModel(id: 4, name: 'mosaad', phone: '+22132131456464'),
    UserModel(id: 5, name: 'yehia', phone: '+22132131456464'),
    UserModel(id: 6, name: 'said', phone: '+22132131456464'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) =>
                buildUserItem(context, users[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey[300],
                  ),
                ),
            itemCount: users.length));
  }

  Widget buildUserItem(BuildContext context, UserModel user) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25.0,
              child: Text(user.id.toString(),
                  style: Theme.of(context).textTheme.headline5),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name.trim().toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  user.phone.trim().toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          ],
        ),
      );
}
