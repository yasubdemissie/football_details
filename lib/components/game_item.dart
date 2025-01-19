import 'package:flutter/material.dart';
import 'package:football_my_app/screens/details.dart';

Widget buildFixtureTile(BuildContext context, String homeTeam,
      String awayTeam, String date, String year, int fixtureId) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 11, 86, 82),
            Color.fromARGB(255, 11, 86, 82),
            // Color.fromARGB(255, 16, 115, 110),
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
              size: 14.0,
              color: Color.fromARGB(255, 231, 231, 231),
            ),
            const SizedBox(width: 5.0),
            Text(
              date,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
        trailing: Text(
          year,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 255, 255, 255),
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