import 'package:flutter/material.dart';
import 'package:football_my_app/helper/date_formatter.dart';
import '../helper/fetchData.dart';
import 'game_details.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({Key? key}) : super(key: key);

  @override
  _FixturesScreenState createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  late Future<Map<String, dynamic>> _fixtures;

  @override
  void initState() {
    super.initState();
    _fetchFixtures();
  }

  void _fetchFixtures() {
    _fixtures =
        fetchPremierLeagueFixtures("2021"); // Example for Premier League
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fixtures,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!['response'].isEmpty) {
          return const Center(child: Text('No fixtures available.'));
        } else {
          var fixtures = snapshot.data!['response'] as List<dynamic>;

          return ListView.builder(
            itemCount: fixtures.length,
            itemBuilder: (context, index) {
              var match = fixtures[index]['fixture'];
              var homeTeam = fixtures[index]['teams']['home']['name'];
              var awayTeam = fixtures[index]['teams']['away']['name'];
              var date = formatDateTime(match['date']);
              var year = formatDateYear(match['date']);
              var fixtureId = match['id']; // Unique ID for the fixture

              return Column(
                children: [
                  Divider(
                    color: Colors.grey, // Line color
                    thickness: 0.2, // Line thickness
                    indent: 16, // Indentation from the left
                    endIndent: 16, // Indentation from the right
                  ),
                  ListTile(
                    // contentPadding: const EdgeInsets.symmetric(
                    //     horizontal: 16.0, vertical: 10.0),
                    leading: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      child: Icon(
                        Icons.sports_soccer,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 20.0,
                      ),
                    ),
                    title: Text(
                      '$homeTeam vs $awayTeam  $fixtureId',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Icons.punch_clock_outlined,
                          size: 15.0,
                          color: Color.fromARGB(255, 1, 44, 144),
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          '$date',
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Color.fromARGB(255, 0, 17, 127),
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '$year',
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 44, 144),
                      ),
                    ),
                    tileColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameDetailsScreen(fixtureId: fixtureId),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.2, // Line thickness
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
