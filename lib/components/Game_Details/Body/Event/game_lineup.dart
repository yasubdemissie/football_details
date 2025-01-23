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
                fit: BoxFit.cover),
          ),
        ),
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

            return LineupPosition(
              goalkeepers: goalkeepers,
              team: team,
              defenders: defenders,
              midfielders: midfielders,
              attackers: attackers,
              index: index,
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

class LineupPosition extends StatelessWidget {
  const LineupPosition({
    super.key,
    required this.goalkeepers,
    required this.team,
    required this.defenders,
    required this.midfielders,
    required this.attackers,
    required this.index,
  });

  final dynamic goalkeepers;
  final dynamic team;
  final dynamic defenders;
  final dynamic midfielders;
  final dynamic attackers;
  final dynamic index;

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
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
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineupGraph(
            position: attackers,
            team: team,
          ),
          LineupGraph(
            position: midfielders,
            team: team,
          ),
          LineupGraph(
            position: defenders,
            team: team,
          ),
          LineupGraph(
            position: goalkeepers,
            team: team,
          ),
        ],
      );
    }
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
                (element) => Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 12,
                      backgroundColor: Color(int.parse(
                          '0xff${team['colors']['player']['primary']}')),
                      child: Text(
                        '${element['player']['number']}',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(int.parse(
                                '0xff${team['colors']['player']['border']}'))),
                      ),
                    ),
                    Text(
                      "${element['player']['name']}",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
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