import 'package:flutter/material.dart';

void main(){
  runApp(Quizzler());
}

class Quizzler extends StatefulWidget {
  const Quizzler({Key key}) : super(key: key);

  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
