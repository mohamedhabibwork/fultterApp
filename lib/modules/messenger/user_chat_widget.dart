import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserChatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Mohamed Habib',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Hello Message ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text('12:30')
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
