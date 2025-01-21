import 'package:flutter/material.dart';

class LineupsWidget extends StatelessWidget {
  final List<dynamic> lineups;

  LineupsWidget({required this.lineups});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/football_field_vertical.jpeg"),
                  fit: BoxFit.cover)),
        ),
        // Image.asset(
        //   "assets/football_field_vertical.jpeg",
        //   fit: BoxFit.fill,
        // ),
        ListView.builder(
          itemCount: lineups.length,
          itemBuilder: (context, index) {
            final teamData = lineups[index];
            final team = teamData['team'];
            final coach = teamData['coach'];
            final startXI = teamData['startXI'];
            final substitutes = teamData['substitutes'];

            final goalkeepers = startXI
                .where((player) => player['player']['pos'] == 'G')
                .toList();
            final defenders = startXI
                .where((player) => player['player']['pos'] == 'D')
                .toList();
            final midfielders = startXI
                .where((player) => player['player']['pos'] == 'M')
                .toList();
            final attackers = startXI
                .where((player) => player['player']['pos'] == 'F')
                .toList();

            const Map<String, String> position = {
              'G': 'Goalkeeper',
              'D': 'Defender',
              'M': 'Midfielder',
              'F': 'Forward',
            };

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LineupGraph(
                  position: goalkeepers,
                  team: team,
                ),
                LineupGraph(
                  position: defenders,
                  team: team,
                ),
                LineupGraph(
                  position: midfielders,
                  team: team,
                ),
                LineupGraph(
                  position: attackers,
                  team: team,
                ),
                // Text("$goalkeepers"),
                // Text("$attackers"),
                // teamCard(team),
                // const SizedBox(height: 10),
                // coachCard(coach),
                // const SizedBox(height: 10),
                // Text(
                //   'Formation: ${teamData['formation']}',
                //   style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 10),
                // const Text(
                //   'Starting XI:',
                //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                // ),
                // // playerList(startXI, team, position),

                // const SizedBox(height: 10),
                // const Text(
                //   'Substitutes:',
                //   style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                // ),
                // playerList(substitutes, team, position),
              ],
            );
          },
        ),
      ],
    );
  }

  Column playerList(players, team, Map<String, String> position) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index]['player'];
            return playerCard(team, player, position);
          },
        ),
      ],
    );
  }

  Row teamCard(team) {
    return Row(
      children: [
        Image.network(
          team['logo'],
          height: 50,
          width: 50,
        ),
        const SizedBox(width: 10),
        Text(
          team['name'],
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  ListTile coachCard(coach) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(coach['photo']),
      ),
      title: Text(coach['name']),
      subtitle: Text(
        'Coach',
        style: TextStyle(color: Colors.green[400]),
      ),
    );
  }

  ListTile playerCard(team, player, Map<String, String> position) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            Color(int.parse('0xff${team['colors']['player']['primary']}')),
        child: Text(
          player['number'].toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        player['name'],
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Text('${position[player['pos']]}'),
    );
  }
}

// TODO: The lineup page illusion

class LineupGraph extends StatelessWidget {
  const LineupGraph({
    super.key,
    required this.position,
    required this.team,
  });

  final dynamic position;
  final dynamic team;

  @override
  Widget build(BuildContext context) {
    print(position);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...position.map(
                (element) => CircleAvatar(
                  backgroundColor: Color(
                      int.parse('0xff${team['colors']['player']['primary']}')),
                  child: Text(
                    '${element[0]['player']['number']}',
                    style: TextStyle(
                        color: Color(int.parse(
                            '0xff${team['colors']['player']['border']}'))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
//             {
//               "player": {
//                 "id": 1456,
//                 "name": "A. Maitland-Niles",
//                 "number": 13,
//                 "pos": "M",
//                 "grid": null
//               }