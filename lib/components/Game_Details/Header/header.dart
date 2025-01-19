import 'package:flutter/material.dart';

class GameDetailsHeader extends StatelessWidget {
  const GameDetailsHeader({
    super.key,
    required this.context,
    required this.leagueLogo,
    required this.homeLogo,
    required this.homeName,
    required this.score,
    required this.awayLogo,
    required this.awayName,
  });

  final BuildContext context;
  final dynamic leagueLogo;
  final dynamic homeLogo;
  final dynamic homeName;
  final dynamic score;
  final dynamic awayLogo;
  final dynamic awayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 51, 23, 23),
            Color.fromARGB(255, 54, 55, 68),
            Color.fromARGB(255, 77, 82, 125),
          ],
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_left_outlined)),
              Container(
                child: Row(
                  children: [
                    Image.network(
                      "$leagueLogo",
                      height: 30,
                      width: 30,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                  ],
                ),
              ),
            ],
          ), // The upper part of the header
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 70,
                width: 50,
                child: Column(
                  children: [
                    Image.network(
                      "$homeLogo",
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "$homeName",
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              Container(
                child: Text(
                  "${score["home"]} - ${score["away"]}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 50,
                child: Column(
                  children: [
                    Image.network(
                      "$awayLogo",
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "$awayName",
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              // Image.network("$homeLogo"),
            ],
          ), // The middle part of the header which shows the teams name and logo
          const SizedBox(height: 56),

          // The lower part of the header which shows the menu list
        ],
      ),
    );
  }
}
