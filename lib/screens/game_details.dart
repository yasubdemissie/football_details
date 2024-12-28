import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:football_my_app/components/game_details_appbar.dart';
import '../helper/fetchData.dart';

class GameDetailsScreen extends StatefulWidget {
  final int fixtureId;

  const GameDetailsScreen({Key? key, required this.fixtureId})
      : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchGameDetails(
            widget.fixtureId), // Fetch game details using the ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No game details available.'));
          } else {
            var data = snapshot.data!;
            var json = jsonEncode(data);
            // var lineups = data['lineups'];
            // var standings = data['standings'];
            var gameInfo = data['response'][0]; // Example structure

            var score = gameInfo["goals"];
            var teams = gameInfo["teams"];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Game Information
                  GameDetailsAppbar(teams: teams),
                  Text(
                    'Game Information',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  // Text('Home Team: ${gameInfo['homeTeam']}'),
                  // Text('Away Team: ${gameInfo['awayTeam']}'),
                  // Text('Date: ${gameInfo['date']}'),
                  const SizedBox(height: 16),
                  SelectableText("$score"),

                  // Lineups

                  // Text(
                  //   'Lineups',
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: lineups.length,
                  //   itemBuilder: (context, index) {
                  //     var lineup = lineups[index];
                  //     return ListTile(
                  //       title: Text(lineup['player']),
                  //       subtitle: Text('Position: ${lineup['position']}'),
                  //     );
                  //   },
                  // ),
                  // const SizedBox(height: 16),

                  // // Standings
                  // Text(
                  //   'Standings',
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: standings.length,
                  //   itemBuilder: (context, index) {
                  //     var team = standings[index];
                  //     return ListTile(
                  //       title: Text('${team['name']}'),
                  //       subtitle: Text('Points: ${team['points']}'),
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
