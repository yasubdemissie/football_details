import 'package:flutter/material.dart';
import 'package:football_my_app/components/Game_Details/Body/detail_menu.dart';
import 'package:football_my_app/components/Game_Details/Body/DetailsBody.dart';

class MainBody extends StatefulWidget {
  final int fixtureId;
  const MainBody({super.key, required this.fixtureId});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  late int _selectedMenuIndex = 0;

  void onClick(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });
  }

  var menus = ["Details", "Lineups", "Statistics", "Standings", "Commentary"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // The Menu for the game details page.
        DetailMenu(
            menus: menus,
            selectedMenuIndex: _selectedMenuIndex,
            onClick: onClick),
        // The Body of the game details page.
        DetailsBody(
            fixtureId: widget.fixtureId, selectedMenuIndex: _selectedMenuIndex),
      ],
    );
  }
}
