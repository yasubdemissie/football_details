import 'package:flutter/material.dart';

class LineupsWidget extends StatelessWidget {
  final List<dynamic> lineups;

  LineupsWidget({required this.lineups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lineups.length,
      itemBuilder: (context, index) {
        final teamData = lineups[index];
        final team = teamData['team'];
        final coach = teamData['coach'];
        final startXI = teamData['startXI'];
        final substitutes = teamData['substitutes'];

        const Map<String, String> Position = {
          'G': 'Goalkeeper',
          'D': 'Defender',
          'M': 'Midfielder',
          'F': 'Forward',
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            teamCard(team),
            const SizedBox(height: 10),
            coachCard(coach),
            const SizedBox(height: 10),
            Text(
              'Formation: ${teamData['formation']}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Starting XI:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            playerList(startXI, team, Position),
            const SizedBox(height: 10),
            const Text(
              'Substitutes:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            playerList(substitutes, team, Position),
          ],
        );
      },
    );
  }

  Column playerList(players, team, Map<String, String> Position) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index]['player'];
            return playerCard(team, player, Position);
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

  ListTile playerCard(team, player, Map<String, String> Position) {
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
      subtitle: Text('${Position[player['pos']]}'),
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