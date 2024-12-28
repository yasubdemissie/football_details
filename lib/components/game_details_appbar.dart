import 'package:flutter/material.dart';

class GameDetailsAppbar extends StatefulWidget {
  final Map<String, dynamic> teams;

  const GameDetailsAppbar({Key? key, required this.teams}) : super(key: key);

  @override
  State<GameDetailsAppbar> createState() => _GameDetailsAppbarState();
}

class _GameDetailsAppbarState extends State<GameDetailsAppbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_left_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.star)),
            ],
          ), // The upper part of the header
          Row(),// The middle part of the header which shows the teams name and logo
          Row(),// The lower part of the header which shows the menu list
        ],
      ),
    );
  }
}
