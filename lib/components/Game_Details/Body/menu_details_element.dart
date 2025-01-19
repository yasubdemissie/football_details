import 'package:flutter/material.dart';

class MenuDetailsContainer extends StatefulWidget {
  final String title;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  const MenuDetailsContainer(
      {super.key,
      required this.title,
      required this.index,
      required this.isSelected,
      required this.onTap});

  @override
  State<MenuDetailsContainer> createState() => _MenuDetailsContainerState();
}

class _MenuDetailsContainerState extends State<MenuDetailsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? const Color.fromARGB(255, 25, 55, 63)
                : const Color.fromARGB(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Text(
              "${widget.title}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
