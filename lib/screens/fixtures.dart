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
    return Scaffold(
      // backgroundColor: const Color(0xFFF3F6FB), // Subtle background color
      appBar: AppBar(
        title: const Text('Fixtures'),
        backgroundColor: const Color(0xFF00274D),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
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
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                var match = fixtures[index]['fixture'];
                var homeTeam = fixtures[index]['teams']['home']['name'];
                var awayTeam = fixtures[index]['teams']['away']['name'];
                var date = formatDateTime(match['date']);
                var year = formatDateYear(match['date']);
                var fixtureId = match['id']; // Unique ID for the fixture

                return Column(
                  children: [
                    if (index > 0)
                      // const CustomDashedDivider(), // Custom divider between tiles
                      const SizedBox(height: 2.0),
                    buildFixtureTile(
                      context,
                      homeTeam,
                      awayTeam,
                      date,
                      year,
                      fixtureId,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget buildFixtureTile(BuildContext context, String homeTeam,
      String awayTeam, String date, String year, int fixtureId) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 20, 20, 50),
            Color.fromARGB(255, 17, 16, 39),
            Color.fromARGB(255, 0, 0, 0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
            blurRadius: 6.0,
            // offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF00274D),
          child: Icon(
            Icons.sports_soccer,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        title: Text(
          '$homeTeam vs $awayTeam',
          style: const TextStyle(
            fontSize: 14.0,
            // fontFamily: String.fromEnvironment("name"),
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            color: Color.fromARGB(221, 236, 236, 236),
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.punch_clock_outlined,
              size: 16.0,
              color: Color.fromARGB(255, 134, 179, 255),
            ),
            const SizedBox(width: 5.0),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 171, 212, 255),
              ),
            ),
          ],
        ),
        trailing: Text(
          year,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 152, 190, 255),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameDetailsScreen(fixtureId: fixtureId),
            ),
          );
        },
      ),
    );
  }
}

class CustomDashedDivider extends StatelessWidget {
  const CustomDashedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 5.0;
          const dashSpacing = 3.0;
          final dashCount = (boxWidth / (dashWidth + dashSpacing)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return Container(
                width: dashWidth,
                height: 1.0,
                color: Colors.grey,
              );
            }),
          );
        },
      ),
    );
  }
}
