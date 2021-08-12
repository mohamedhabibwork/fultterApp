import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class BMIResultScreen extends StatelessWidget {
  final double result;
  final int age;
  final int weight;
  final double height;
  final bool gender;

  BMIResultScreen(this.result, this.age, this.weight, this.height, this.gender);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Gender : ' + (gender ? 'FeMale' : 'Male'),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Result : ${result.round()}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Age : $age Years',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Weight : $weight KG',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Height : $height CM',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
