import 'package:flutter/material.dart';
import 'package:football_my_app/components/Game_Details/Body/detail_menu.dart';
import 'package:football_my_app/components/Game_Details/Body/DetailsBody.dart';
import 'package:football_my_app/components/Game_Details/Body/Event/main_body.dart';
// import 'package:football_my_app/components/Game_Details/Body/DetailMenu.dart';
// import 'package:football_my_app/components/Game_Details/Body/Event/game_event.dart';
// import 'package:football_my_app/components/Game_Details/Body/Event/game_lineup.dart';
// import 'package:football_my_app/components/Game_Details/Body/Event/game_stats.dart';
import 'package:football_my_app/components/Game_Details/header/header.dart';
// import 'package:football_my_app/components/Game_Details/Body/menu_details_element.dart';
import '../helper/fetch_data.dart';

class GameDetailsScreen extends StatefulWidget {
  final int fixtureId;

  const GameDetailsScreen({Key? key, required this.fixtureId})
      : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  // late int _selectedMenuIndex = 0;

  // void onClick(int index) {
  //   setState(() {
  //     _selectedMenuIndex = index;
  //   });
  // }

  // var menus = ["Details", "Lineups", "Statistics", "Standings", "Commentary"];

  // List<Widget> _selectedWidgets = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
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
            // var lineups = gameInfo["lineups"] ?? [];
            // var events = gameInfo["events"] ?? [];
            // var team1Stats = gameInfo["statistics"][0]["statistics"] ?? [];
            // var team2Stats = gameInfo["statistics"][1]["statistics"] ?? [];

            // _selectedWidgets = [
            //   EventDetails(events: events),
            //   LineupsWidget(lineups: lineups),
            //   buildStatisticsDisplay(team1Stats, team2Stats),
            //   Text('Game Standing Content'), // Replace with actual widget
            //   Text('Game Commnetory Content'), // Replace with actual widget
            // ];

            return SafeArea(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The Header for the game details page.
                    GameDetailsHeader(
                      context: context,
                      leagueLogo: gameInfo["league"]["logo"],
                      homeLogo: gameInfo["teams"]["home"]["logo"],
                      homeName: gameInfo["teams"]["home"]["name"],
                      score: gameInfo["goals"],
                      awayLogo: gameInfo["teams"]["away"]["logo"],
                      awayName: gameInfo["teams"]["away"]["name"],
                    ),
                    MainBody(fixtureId: widget.fixtureId),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
 
