import 'package:flutter/material.dart';

class PlayerStatsScreen extends StatelessWidget {
  const PlayerStatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Player Stats Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
