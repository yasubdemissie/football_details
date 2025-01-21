import 'package:flutter/material.dart';
// import 'package:football_my_app/components/Game_Details/Body/DetailMenu.dart';
import 'package:football_my_app/components/Game_Details/Body/Event/game_details.dart';
import 'package:football_my_app/components/Game_Details/Body/Event/game_lineup.dart';
import 'package:football_my_app/components/Game_Details/Body/Event/game_stats.dart';
import 'package:football_my_app/helper/fetch_data.dart';

class DetailsBody extends StatefulWidget {
  final int fixtureId;
  final int selectedMenuIndex;

  const DetailsBody(
      {super.key, required this.fixtureId, required this.selectedMenuIndex});

  @override
  State<DetailsBody> createState() => _DetailsBodyState();
}

class _DetailsBodyState extends State<DetailsBody> {
  List<Widget> _selectedWidgets = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchGameDetails(widget.fixtureId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No game details available.'));
        } else {
          var gameInfo = snapshot.data!['response'][0];
          var lineups = gameInfo["lineups"] ?? [];
          var events = gameInfo["events"] ?? [];
          var team1Stats = gameInfo["statistics"][0]["statistics"] ?? [];
          var team2Stats = gameInfo["statistics"][1]["statistics"] ?? [];

          _selectedWidgets = [
            EventDetails(events: events),
            LineupsWidget(lineups: lineups),
            buildStatisticsDisplay(team1Stats, team2Stats),
            const Text('Game Standing Content'), // Replace with actual widget
            const Text('Game Commnetory Content'), // Replace with actual widget
          ];

          return _selectedWidgets[widget.selectedMenuIndex];
        }
      },
    );
  }
}
