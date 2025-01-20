import 'package:flutter/material.dart';
import 'package:football_my_app/screens/details.dart';

Widget buildFixtureTile(BuildContext context, String homeTeam, String awayTeam,
    String date, String year, int fixtureId, String homeLogo, String awayLogo) {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 12, 32, 44),
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 0, 0, 0),
          // Color.fromARGB(255, 16, 115, 110),
          Color.fromARGB(255, 12, 35, 53),
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
      title: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: 23,
                  child: Image.network(
                    homeLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                homeTeam,
                style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: 23,
                  child: Image.network(
                    awayLogo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                awayTeam,
                style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
              ),
            ],
          )
        ],
      ),
      trailing: Column(
        children: [
          Text(
            date,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Text(
            year,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
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
