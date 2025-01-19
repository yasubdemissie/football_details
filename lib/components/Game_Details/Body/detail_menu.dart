import 'package:flutter/material.dart';
import 'package:football_my_app/components/Game_Details/Body/menu_details_element.dart';

class DetailMenu extends StatefulWidget {
  final List<String> menus;
  int selectedMenuIndex;
  final Function(int) onClick;
  DetailMenu({super.key, required this.menus, required this.selectedMenuIndex, required this.onClick});

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.menus.asMap().entries.map((entry) {
            int index = entry.key;
            String menu = entry.value;
            return MenuDetailsContainer(
              title: menu,
              index: index,
              isSelected: widget.selectedMenuIndex == index,
              onTap: () {
                setState(() {
                  // widget.selectedMenuIndex = index;
                  widget.onClick(index);
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
