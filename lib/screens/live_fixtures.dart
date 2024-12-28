import 'package:flutter/material.dart';
import 'package:football_my_app/helper/date_formatter.dart';
import '../helper/fetchData.dart';
import 'game_details.dart';

class LiveFixturesScreen extends StatefulWidget {
  const LiveFixturesScreen({Key? key}) : super(key: key);

  @override
  _LiveFixturesScreenState createState() => _LiveFixturesScreenState();
}

class _LiveFixturesScreenState extends State<LiveFixturesScreen> {
  late Future<Map<String, dynamic>> _fixtures;

  @override
  void initState() {
    super.initState();
    _fetchFixtures();
  }

  void _fetchFixtures() {
    _fixtures = fetchData(); // Example for Premier League
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

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0), // Add spacing around the tile
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(
                      255, 0, 0, 0), // Background color for the icon
                  child: const Icon(
                    Icons.sports_soccer,
                    color: Color.fromARGB(255, 255, 255, 255), // Icon color
                    size: 20.0, // Icon size
                  ),
                ),
                title: Text(
                  '$homeTeam vs $awayTeam',
                  style: const TextStyle(
                    fontSize: 15.0, // Increase font size
                    fontWeight: FontWeight.w500, // Bold for emphasis
                    fontStyle: FontStyle.italic,
                    color: Colors.black87, // Title color
                  ),
                ),
                subtitle: Row(
                  children: [
                    const Icon(
                      Icons.punch_clock_outlined,
                      size: 15.0, // Icon size
                      color: Color.fromARGB(255, 1, 44, 144), // Icon color
                    ),
                    const SizedBox(
                        width: 5.0), // Add spacing between icon and text
                    Text(
                      '$date',
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Color.fromARGB(
                            255, 0, 17, 127), // Subtle color for the date
                      ),
                    ),
                  ],
                ), // Add a calendar icon
                trailing: Text(
                  '$year',
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 44,
                        144), // Match the icon color for consistency
                  ),
                ),
                tileColor: const Color.fromARGB(
                    255, 255, 252, 252), // Light background for the ListTile
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      12.0), // Rounded corners for a modern look
                ),
                onTap: () {
                  // Handle tap: Navigate to the details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GameDetailsScreen(fixtureId: fixtureId),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
