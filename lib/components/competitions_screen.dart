import 'package:flutter/material.dart';

class CompetitionDetailsScreen extends StatelessWidget {
  const CompetitionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Competitions Table"),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: FlexColumnWidth(),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
          },
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('point',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Goal', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('1'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Hawassa FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('2'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Buna FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('3'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Fasil FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('4'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sidama buna FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('5'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Mekelakeya FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('6'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Butajira FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('7'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Woliwalo FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('8'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Mekele FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('9'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Arbaminch FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('10'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Georgis FC'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('22'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('59'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
