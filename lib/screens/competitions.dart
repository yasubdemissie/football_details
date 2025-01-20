import 'package:flutter/material.dart';
import 'package:football_my_app/helper/fetchData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompetitionsScreen extends StatefulWidget {
  @override
  _CompetitionsScreenState createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends State<CompetitionsScreen> {
  late Future<List<Map<String, dynamic>>> competitions;

  @override
  void initState() {
    super.initState();
    competitions = fetchCompetitions();
  }

  Future<List<Map<String, dynamic>>> fetchCompetitions() async {
    final url = '$url2/leagues';
    final headers = {
      'x-rapidapi-key': apiKey2,
      'x-rapidapi-host': 'v3.football.api-sports.io'
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    var data = jsonDecode(response.body);

    // Return a list of leagues
    List<Map<String, dynamic>> leagues = [];
    for (var league in data['response']) {
      leagues.add({
        'id': league['league']['id'],
        'name': league['league']['name'],
        'logo':
            '$url2/football/leagues/${league['league']['id']}.png',
      });
    }
    return leagues;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: competitions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No competitions available.'));
        } else {
          var leagues = snapshot.data!;
          return ListView.builder(
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              var league = leagues[index];
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(league['logo']),
                  radius: 30.0, // Adjust the radius for logo size
                ),
                title: Text(
                  league['name'],
                  style: TextStyle(
                    fontSize: 18.0, // Adjust text size
                    fontWeight: FontWeight.bold, // Make the title bold
                    color: Colors.black87, // Set text color
                  ),
                ),
                subtitle: Text(
                  'Tap for details', // Optional subtitle for additional information
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey, // Subtle color for the subtitle
                  ),
                ),
                tileColor: const Color.fromARGB(
                    255, 255, 255, 255), // Set a background color for the tile
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Round the corners
                ),
                onTap: () {
                  // Handle tap event here, for example:
                  // Navigate to the competition's details or fixtures.
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CompetitionDetailsScreen(leagueId: league['id'])),
                  // );
                },
                trailing: Icon(
                  Icons
                      .arrow_forward_ios, // Add an arrow icon for visual indication
                  size: 16.0,
                  color: Colors.black45,
                ),
              );
            },
          );
        }
      },
    );
  }
}
