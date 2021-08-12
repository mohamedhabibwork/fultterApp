import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return Container(
    width: 60,
    child: Column(
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            const CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/64292519?s=400&u=c998d7ac1b9e7003ce2986e26a1d31c0c2d83642&v=4'),
            ),
            const CircleAvatar(
              radius: 8.0,
              backgroundColor: Colors.white,
            ),
            const CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.greenAccent,
            ),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Text(
          'Mohamed Habib',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            locale: Locale('en'),
          ),
        ),
      ],
    ),
  );
 }
}