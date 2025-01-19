import 'package:flutter/material.dart';

Widget buildStatisticsDisplay(
  List<dynamic> team1Stats,
  List<dynamic> team2Stats,
) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: team1Stats.length,
          itemBuilder: (context, index) {
            final team1Value = team1Stats[index]['value'] ?? '-';
            final team2Value = team2Stats[index]['value'] ?? '-';
            final statType = team1Stats[index]['type'];

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  coloredStatNumber(team1Value, team2Value),
                  Expanded(
                    child: Text(
                      statType,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  coloredStatNumber(team2Value, team1Value),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

Container coloredStatNumber(team1Value, team2Value) {
  return Container(
    decoration: BoxDecoration(
      color: team1Value.toString().contains('%')
          ? const Color.fromARGB(0, 0, 0, 0)
          : team1Value.compareTo(team2Value) < 0
              ? const Color.fromARGB(0, 0, 0, 0)
              : const Color.fromARGB(107, 92, 219, 96),
      // team2Value ? Color.fromARGB(143, 76, 175, 79):  Color.fromARGB(0, 76, 175, 79),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        '$team1Value',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}
