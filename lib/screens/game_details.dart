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
            var awayLogo = away["logo"];
            List<String> menus = [
              "Details",
              "Lineups",
              "Statistics",
              "Standings"
            ];

            // For the main Part
            var events = gameInfo['events'];
            final elapsedTime = events[0]["time"]["elapsed"];
            final teamName = events[0]["team"]["name"];
            final teamLogo = events[0]["team"]["logo"];
            final playerName = events[0]["player"]["name"];
            final assistName = events[0]["assist"]["name"];
            final eventType = events[0]["type"] ?? "";
            final eventDetail = events[0]["detail"] ?? "";
            var eventLength = events.length;

            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Column(
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
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.network("$homeLogo"),
                            ),
                            Container(
                              child:
                                  Text("${score["home"]} - ${score["away"]}"),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.network("$awayLogo"),
                            ),
                            // Image.network("$homeLogo"),
                          ],
                        ), // The middle part of the header which shows the teams name and logo
                        const SizedBox(height: 56),

                        Container(
                          height: 70,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: menus.asMap().entries.map((entry) {
                                int index = entry.key;
                                String menu = entry.value;
                                return MenuDetailsContainer(
                                    title: menu, index: index);
                              }).toList(),
                            ),
                          ),
                        ), // The lower part of the header which shows the menu list
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("$teamName"),
                    GameEventsCard(
                        teamLogo: teamLogo,
                        playerName: playerName,
                        assistName: assistName,
                        teamName: teamName,
                        elapsedTime: elapsedTime)
                    // Text("$away"),
                    // ListView(
                    //   children: menus.asMap().entries.map((entry) {
                    //     return Text("Datas");
                    //   }).toList(),
                    // ),

                    // ListView.builder(
                    //   itemCount: events.length,
                    //   itemBuilder: (context, index) {
                    //     return Text("$index");
                    //       final event = events[index];
                    //       final elapsedTime = event["time"]["elapsed"];
                    //       final teamName = event["team"]["name"];
                    //       final teamLogo = event["team"]["logo"];
                    //       final playerName = event["player"]["name"];
                    //       final assistName = event["assist"]["name"];
                    //       final eventType = event["type"];
                    //       final eventDetail = event["detail"];

                    //       return Text(
                    //           "$playerName $eventType $eventDetail $teamName $elapsedTime ");
                    //       // return Card(
                    //       //   margin: const EdgeInsets.symmetric(
                    //       //       horizontal: 12.0, vertical: 8.0),
                    //       //   elevation: 4,
                    //       //   shape: RoundedRectangleBorder(
                    //       //     borderRadius: BorderRadius.circular(12.0),
                    //       //   ),
                    //       //   child: ListTile(
                    //       //     leading: teamLogo != null
                    //       //         ? Image.network(
                    //       //             teamLogo,
                    //       //             height: 40,
                    //       //             width: 40,
                    //       //             fit: BoxFit.cover,
                    //       //           )
                    //       //         : const Icon(
                    //       //             Icons.sports_soccer,
                    //       //             color: Colors.grey,
                    //       //             size: 40,
                    //       //           ),
                    //       //     title: Text(
                    //       //       playerName,
                    //       //       style: const TextStyle(
                    //       //         fontSize: 16.0,
                    //       //         fontWeight: FontWeight.bold,
                    //       //       ),
                    //       //     ),
                    //       //     subtitle: Column(
                    //       //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       //       children: [
                    //       //         if (assistName != null &&
                    //       //             assistName.isNotEmpty)
                    //       //           Text(
                    //       //             "Assist: $assistName",
                    //       //             style:
                    //       //                 const TextStyle(color: Colors.grey),
                    //       //           ),
                    //       //         Text(
                    //       //           "$eventType - $eventDetail",
                    //       //           style:
                    //       //               const TextStyle(color: Colors.black87),
                    //       //         ),
                    //       //         Text(
                    //       //           "$teamName at $elapsedTime'",
                    //       //           style:
                    //       //               const TextStyle(color: Colors.blueGrey),
                    //       //         ),
                    //       //       ],
                    //       //     ),
                    //       //     trailing: Text(
                    //       //       "$elapsedTime'",
                    //       //       style: const TextStyle(
                    //       //         fontWeight: FontWeight.bold,
                    //       //         fontSize: 14.0,
                    //       //         color: Colors.black54,
                    //       //       ),
                    //       //     ),
                    //       //   ),
                    //       // );
                    //   },
                    // ),
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

class GameEventsCard extends StatelessWidget {
  const GameEventsCard({
    super.key,
    required this.teamLogo,
    required this.playerName,
    required this.assistName,
    required this.teamName,
    required this.elapsedTime,
  });

  final dynamic teamLogo;
  final dynamic playerName;
  final dynamic assistName;
  final dynamic teamName;
  final dynamic elapsedTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: teamLogo != null
              ? Image.network(
                  teamLogo,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                )
              : const Icon(
                  Icons.sports_soccer,
                  color: Colors.grey,
                  size: 40,
                ),
          title: Text(
            playerName,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (assistName != null && assistName.isNotEmpty)
                Text(
                  "Assist: $assistName",
                  style: const TextStyle(color: Colors.grey),
                ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "⚽ Goal $teamName at $elapsedTime'",
                style: const TextStyle(color: Colors.blueGrey),
              ),
            ],
          ),
          trailing: Text(
            "$elapsedTime'",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Colors.black54,
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
  const MenuDetailsContainer(
      {super.key, required this.title, required this.index});

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
                ? const Color.fromARGB(0, 255, 255, 255)
                : const Color.fromARGB(62, 71, 85, 97),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            child: Text("${widget.title}"),
            onTap: () {
              setState(() {
                _selectedMenuIndex = widget.index;
              });
            },
          ),
        ),
      ),
    );
  }
}
