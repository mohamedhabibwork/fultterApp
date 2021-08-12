import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/modules/messenger/story_widget.dart';
import 'package:todo/modules/messenger/user_chat_widget.dart';

class MessengerScreen extends StatelessWidget {

  final List<Array> chats =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: <Widget>[
            const CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/64292519?s=400&u=c998d7ac1b9e7003ce2986e26a1d31c0c2d83642&v=4'),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              'Chats',
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: Theme.of(context).primaryColorLight,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              child: Icon(
                Icons.notifications,
                size: 16,
                color: Theme.of(context).primaryColorLight,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                    ),
                    const Text('Search')
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(width: 15,),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  itemCount: chats.length + 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 15,),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => buildChatItem(),
                itemCount: chats.length + 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() => UserChatWidget();
  Widget buildStoryItem() => StoryWidget();
}
