import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:football_my_app/components/event_details.dart';
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        title: const Text(
          'Game Details',
          style: TextStyle(color: Colors.white),
        ),
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
            // var json = jsonEncode(data);
            // var lineups = data['lineups'];
            // var standings = data['standings'];
            var gameInfo = data['response'][0]; // Example structure

            // For the upper section of the game details
            var score = gameInfo["goals"];
            var teams = gameInfo["teams"];
            var leagueLogo = gameInfo["league"]["logo"];
            var home = teams["home"];
            var homeLogo = home["logo"];
            var away = teams["away"];
            var awayName = away["name"];
            var homeName = home["name"];
            var awayLogo = away["logo"];
            List<String> menus = [
              "Details",
              "Lineups",
              "Statistics",
              "Standings",
              "Commentators"
            ];

            // For the main Part
            var events = gameInfo['events'];
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(color: Colors.black),
              // padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
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
                                onPressed: () {},
                                icon: Icon(Icons.arrow_left_outlined)),
                            Container(
                              child: Row(
                                children: [
                                  Image.network(
                                    "$leagueLogo",
                                    height: 30,
                                    width: 30,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.share)),
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
                  ),
                  Container(
                    height: 70,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: menus.asMap().entries.map((entry) {
                          int index = entry.key;
                          String menu = entry.value;
                          return MenuDetailsContainer(
                              title: menu, index: _selectedMenuIndex);
                        }).toList(),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  // Text("$teamName"),
                  Expanded(
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
                  )
                  // Column(
                  //   children: List.generate(events.length, (i) {
                  //     final event = events[i];
                  //     final elapsedTime = event["time"]["elapsed"];
                  //     final teamName = event["team"]["name"];
                  //     final teamLogo = event["team"]["logo"];
                  //     final playerName = event["player"]["name"];
                  //     final assistName = event["assist"]["name"];
                  //     final eventType = event["type"];
                  //     return GameEventsCard(
                  //       teamLogo: teamLogo,
                  //       playerName: playerName,
                  //       assistName: assistName,
                  //       teamName: teamName,
                  //       elapsedTime: elapsedTime,
                  //       eventType: eventType,
                  //     );
                  //   }),
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
      margin: EdgeInsets.all(6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadowColor: const Color.fromARGB(255, 171, 169, 169),
      color: Colors.black38,
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
  MenuDetailsContainer({super.key, required this.title, this.index = 0});

  @override
  State<MenuDetailsContainer> createState() => _MenuDetailsContainerState();
}

class _MenuDetailsContainerState extends State<MenuDetailsContainer> {
  int _selectedMenuIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _selectedMenuIndex != widget.index
                ? const Color.fromARGB(147, 255, 255, 255)
                : const Color.fromARGB(0, 190, 13, 13),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            child: Text(
              "${widget.title}",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              setState(() {
                print("selected${_selectedMenuIndex}");
                _selectedMenuIndex = widget.index;
                print("selected${_selectedMenuIndex}");
              });
            },
          ),
        ),
      ),
    );
  }
}
