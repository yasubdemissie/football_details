import 'package:flutter/material.dart';
import 'package:football_my_app/components/game_item.dart';
import 'package:football_my_app/helper/date_formatter.dart';
import '../helper/fetchData.dart';
import 'details.dart';

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
              var homeLogo = fixtures[index]['teams']['home']['logo'];
              var awayLogo = fixtures[index]['teams']['home']['logo'];
              var date = formatDateTime(match['date']);
              var year = formatDateYear(match['date']);
              var fixtureId = match['id']; // Unique ID for the fixture

              return buildFixtureTile(context, homeTeam, awayTeam, date, year, fixtureId, homeLogo, awayLogo);
            },
          );
        }
      },
    );
  }
}
