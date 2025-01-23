import 'package:flutter/material.dart';
import 'package:football_my_app/components/competitions_screen.dart';
import 'package:football_my_app/helper/fetch_data.dart';
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
    const url = '$url1/leagues';
    final headers = {
      'x-rapidapi-key': apiKey1,
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
        'logo': '$url1/football/leagues/${league['league']['id']}.png',
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
                  style: const TextStyle(
                    fontSize: 18.0, // Adjust text size
                    fontWeight: FontWeight.bold, // Make the title bold
                    color: Colors.black87, // Set text color
                  ),
                ),
                subtitle: const Text(
                  'Tap for details',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                tileColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Round the corners
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CompetitionDetailsScreen()),
                  );
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios,
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
