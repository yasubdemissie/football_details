import 'package:flutter/material.dart';
import 'package:football_my_app/components/game_lineup.dart';
import 'package:football_my_app/components/game_stats.dart';
import 'package:flutter/rendering.dart';
import '../helper/fetchData.dart';

class GameDetailsScreen extends StatefulWidget {
  final int fixtureId;

  const GameDetailsScreen({Key? key, required this.fixtureId})
      : super(key: key);

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  late int _selectedMenuIndex = 0;
  List<Widget> _selectedWidgets = [];
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
            var lineups = gameInfo["lineups"] ?? [];
            var events = gameInfo["events"] ?? [];
            var team1Stats = gameInfo["statistics"][0]["statistics"] ?? [];
            var team2Stats = gameInfo["statistics"][1]["statistics"] ?? [];
            var menus = [
              "Details",
              "Lineups",
              "Statistics",
              "Standings",
              "Commentary"
            ];

            _selectedWidgets = [
              EventDetails(events: events),
              LineupsWidget(lineups: lineups),
              // Text('Game Linpeup Content'), // Replace with actual widget
              buildStatisticsDisplay(team1Stats, team2Stats),
              Text('Game Standing Content'), // Replace with actual widget
              Text('Game Commnetory Content'), // Replace with actual widget
            ];

            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailsHeader(
                    gameInfo["league"]["logo"],
                    gameInfo["teams"]["home"]["logo"],
                    gameInfo["teams"]["home"]["name"],
                    gameInfo["goals"],
                    gameInfo["teams"]["away"]["logo"],
                    gameInfo["teams"]["away"]["name"],
                  ),
                  detailsMenu(menus),
                  Expanded(
                    child: _selectedWidgets[_selectedMenuIndex],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Container detailsMenu(List<String> menus) {
    return Container(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: menus.asMap().entries.map((entry) {
            int index = entry.key;
            String menu = entry.value;
            return MenuDetailsContainer(
              title: menu,
              index: index,
              isSelected: _selectedMenuIndex == index,
              onTap: () {
                setState(
                  () => _selectedMenuIndex = index,
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Container detailsHeader(
      leagueLogo, homeLogo, homeName, score, awayLogo, awayName) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 51, 23, 23),
            Color.fromARGB(255, 54, 55, 68),
            Color.fromARGB(255, 77, 82, 125),
          ],
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_left_outlined)),
              Container(
                child: Row(
                  children: [
                    Image.network(
                      "$leagueLogo",
                      height: 30,
                      width: 30,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                  ],
                ),
              ),
            ],
          ), // The upper part of the header
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 70,
                width: 50,
                child: Column(
                  children: [
                    Image.network(
                      "$homeLogo",
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "$homeName",
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              Container(
                child: Text(
                  "${score["home"]} - ${score["away"]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 50,
                child: Column(
                  children: [
                    Image.network(
                      "$awayLogo",
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "$awayName",
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              // Image.network("$homeLogo"),
            ],
          ), // The middle part of the header which shows the teams name and logo
          const SizedBox(height: 56),

          // The lower part of the header which shows the menu list
        ],
      ),
    );
  }
}

class EventDetails extends StatelessWidget {
  const EventDetails({
    super.key,
    required this.events,
  });

  final dynamic events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final elapsedTime = event["time"]["elapsed"];
            final teamName = event["team"]["name"];
            final teamLogo = event["team"]["logo"];
            final playerName = event["player"]["name"];
            final assistName = event["assist"]["name"];
            final eventType = event["type"];
            return GameEventsCard(
              teamLogo: teamLogo,
              playerName: playerName,
              assistName: assistName,
              teamName: teamName,
              elapsedTime: elapsedTime,
              eventType: eventType,
            );
          }),
    );
  }
}

class GameEventsCard extends StatelessWidget {
  const GameEventsCard({
    super.key,
    required this.teamLogo,
    required this.playerName,
    required this.assistName,
    required this.teamName,
    required this.elapsedTime,
    required this.eventType,
  });

  final dynamic teamLogo;
  final dynamic playerName;
  final dynamic assistName;
  final dynamic teamName;
  final dynamic elapsedTime;
  final dynamic eventType;

  @override
  Widget build(BuildContext context) {
    String type = eventType == "Goal"
        ? "⚽ Goal $teamName at $elapsedTime'"
        : "Substitution at $elapsedTime'";
    String assist =
        type == "Goal" ? "Assist: $assistName" : "Sub out $assistName";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadowColor: const Color.fromARGB(255, 129, 129, 129),
      color: const Color.fromARGB(189, 0, 0, 0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: teamLogo != null
              ? Image.network(
                  teamLogo,
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                )
              : const Icon(
                  Icons.sports_soccer,
                  color: Colors.grey,
                  size: 25,
                ),
          title: Text(
            playerName,
            style: const TextStyle(
              fontSize: 14.0,
              color: Color.fromARGB(255, 220, 220, 220),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (assistName != null && assistName.isNotEmpty)
                Text(
                  "$assist",
                  style: const TextStyle(color: Colors.grey),
                ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "$type",
                style:
                    const TextStyle(color: Color.fromARGB(255, 113, 145, 162)),
              ),
            ],
          ),
          trailing: Text(
            "$elapsedTime'",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Color.fromARGB(137, 216, 216, 216),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuDetailsContainer extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  const MenuDetailsContainer(
      {super.key,
      required this.title,
      required this.index,
      required this.isSelected,
      required this.onTap});

  @override
  State<MenuDetailsContainer> createState() => _MenuDetailsContainerState();
}

class _MenuDetailsContainerState extends State<MenuDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color.fromARGB(255, 25, 55, 63)
                : const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Text(
              "${widget.title}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
