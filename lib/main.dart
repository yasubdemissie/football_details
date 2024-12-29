import 'package:flutter/material.dart';
import 'package:football_my_app/screens/champions_league.dart';
import 'package:football_my_app/screens/competitions.dart';
import 'package:football_my_app/screens/live_fixtures.dart';
import 'screens/fixtures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Football Streaming App',
      theme: ThemeData.dark(
          // primarySwatch: Colors.blue,
          ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    FixturesScreen(), // Index 0
    LiveFixturesScreen(), // Index 1
    ChampionsLeagueFixture(), // Index 2
    CompetitionsScreen(), // Index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Change icon color to white
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Image.network(
                  "https://thumbs.dreamstime.com/z/burning-gold-trophy-cup-black-background-isolated-flames-around-concept-success-effort-88335526.jpg?ct=jpeg")
            ],
          ),
        ),
        title: const Text(
          'YasDW Soccer',
          style: TextStyle(
            fontSize: 19, // Increase font size
            fontStyle: FontStyle.italic, // Add italic style
            fontWeight: FontWeight.bold, // Make it bold
            color: Color.fromARGB(255, 178, 178, 178), // White text color
            letterSpacing: 1.5, // Add letter spacing for a cleaner look
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 0, 0, 0), // Change background color to a more appealing shade
        elevation: 4, // Add slight shadow for a floating effect
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 0, 0, 0),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              color: _selectedIndex == 0 ? Colors.white : Colors.grey,
              icon: const Icon(Icons.list_alt),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              icon: const Icon(Icons.live_tv),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              icon: const Icon(Icons.sports_soccer),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              color: _selectedIndex == 3 ? Colors.white : Colors.grey,
              icon: const Icon(Icons.flag),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
