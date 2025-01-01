import 'package:flutter/material.dart';

class LineupsWidget extends StatelessWidget {
  final List<dynamic> lineups;

  LineupsWidget({required this.lineups});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: lineups.length,
        itemBuilder: (context, index) {
          final teamData = lineups[index];
          final team = teamData['team'];
          final coach = teamData['coach'];
          final startXI = teamData['startXI'];
          final substitutes = teamData['substitutes'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            // child: Text("$teamData"),
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        team['logo'],
                        height: 50,
                        width: 50,
                      ),
                      SizedBox(width: 10),
                      Text(
                        team['name'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(coach['photo']),
                    ),
                    title: Text(coach['name']),
                    subtitle: Text('Coach'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Formation: ${teamData['formation']}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Starting XI:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: startXI.length,
                        itemBuilder: (context, index) {
                          final player = startXI[index]['player'];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                player['number'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(int.parse(
                                  '0xff${team['colors']['player']['primary']}')),
                            ),
                            title: Text(player['name']),
                            subtitle: Text(
                                '${player['pos']} | Grid: ${player['grid']}'),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Substitutes:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: substitutes.length,
                        itemBuilder: (context, index) {
                          final player = substitutes[index]['player'];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(
                                player['number'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Color(int.parse(
                                  '0xff${team['colors']['player']['primary']}')),
                            ),
                            title: Text(player['name']),
                            subtitle: Text(player['pos']),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: LineupsWidget(
//       lineups: [
//         // Paste your JSON data here as Dart Map
//         {
//           "team": {
//             "id": 55,
//             "name": "Brentford",
//             "logo": "https://media.api-sports.io/football/teams/55.png",
//             "colors": {
//               "player": {
//                 "primary": "ff0000",
//                 "number": "000000",
//                 "border": "0099cc"
//               },
//               "goalkeeper": {
//                 "primary": "0099cc",
//                 "number": "000000",
//                 "border": "0099cc"
//               }
//             }
//           },
//           "coach": {
//             "id": 90,
//             "name": "T. Frank",
//             "photo": "https://media.api-sports.io/football/coachs/90.png"
//           },
//           "formation": "3-5-2",
//           "startXI": [
//             {
//               "player": {
//                 "id": 19465,
//                 "name": "David Raya",
//                 "number": 1,
//                 "pos": "G",
//                 "grid": "1:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 19124,
//                 "name": "P. Jansson",
//                 "number": 13,
//                 "pos": "D",
//                 "grid": "2:3"
//               }
//             },
//             {
//               "player": {
//                 "id": 1119,
//                 "name": "K. Ajer",
//                 "number": 15,
//                 "pos": "D",
//                 "grid": "2:2"
//               }
//             },
//             {
//               "player": {
//                 "id": 19346,
//                 "name": "R. Henry",
//                 "number": 3,
//                 "pos": "M",
//                 "grid": "2:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 19789,
//                 "name": "E. Pinnock",
//                 "number": 5,
//                 "pos": "D",
//                 "grid": "3:5"
//               }
//             },
//             {
//               "player": {
//                 "id": 30407,
//                 "name": "C. Nørgaard",
//                 "number": 6,
//                 "pos": "M",
//                 "grid": "3:4"
//               }
//             },
//             {
//               "player": {
//                 "id": 19352,
//                 "name": "Sergi Canós",
//                 "number": 7,
//                 "pos": "M",
//                 "grid": "3:3"
//               }
//             },
//             {
//               "player": {
//                 "id": 25073,
//                 "name": "V. Janelt",
//                 "number": 27,
//                 "pos": "M",
//                 "grid": "3:2"
//               }
//             },
//             {
//               "player": {
//                 "id": 13799,
//                 "name": "F. Onyeka",
//                 "number": 13,
//                 "pos": "M",
//                 "grid": "3:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 19974,
//                 "name": "I. Toney",
//                 "number": 17,
//                 "pos": "F",
//                 "grid": "4:2"
//               }
//             },
//             {
//               "player": {
//                 "id": 15589,
//                 "name": "B. Mbeumo",
//                 "number": 19,
//                 "pos": "F",
//                 "grid": "4:1"
//               }
//             }
//           ],
//           "substitutes": [
//             {
//               "player": {
//                 "id": 19345,
//                 "name": "M. Sørensen",
//                 "number": 29,
//                 "pos": "D",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 122139,
//                 "name": "M. Bidstrup",
//                 "number": 28,
//                 "pos": "M",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 19363,
//                 "name": "M. Forss",
//                 "number": 9,
//                 "pos": "F",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 19343,
//                 "name": "P. Gunnarsson",
//                 "number": 13,
//                 "pos": "G",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 2699,
//                 "name": "S. Ghoddos",
//                 "number": 14,
//                 "pos": "F",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 15649,
//                 "name": "Y. Wissa",
//                 "number": 11,
//                 "pos": "M",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 17772,
//                 "name": "C. Goode",
//                 "number": 4,
//                 "pos": "D",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 37440,
//                 "name": "H. Dervişoğlu",
//                 "number": 21,
//                 "pos": "F",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 13745,
//                 "name": "M. Rasmussen",
//                 "number": 30,
//                 "pos": "D",
//                 "grid": null
//               }
//             }
//           ]
//         },
//         {
//           "team": {
//             "id": 42,
//             "name": "Arsenal",
//             "logo": "https://media.api-sports.io/football/teams/42.png",
//             "colors": {
//               "player": {
//                 "primary": "0a244d",
//                 "number": "ffffff",
//                 "border": "44c62a"
//               },
//               "goalkeeper": {
//                 "primary": "44c62a",
//                 "number": "ffffff",
//                 "border": "44c62a"
//               }
//             }
//           },
//           "coach": {
//             "id": 7248,
//             "name": "Mikel Arteta",
//             "photo": "https://media.api-sports.io/football/coachs/7248.png"
//           },
//           "formation": "4-2-3-1",
//           "startXI": [
//             {
//               "player": {
//                 "id": 1438,
//                 "name": "B. Leno",
//                 "number": 1,
//                 "pos": "G",
//                 "grid": "1:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 46792,
//                 "name": "Pablo Marí",
//                 "number": 22,
//                 "pos": "D",
//                 "grid": "2:4"
//               }
//             },
//             {
//               "player": {
//                 "id": 19012,
//                 "name": "C. Chambers",
//                 "number": 21,
//                 "pos": "D",
//                 "grid": "2:3"
//               }
//             },
//             {
//               "player": {
//                 "id": 1117,
//                 "name": "K. Tierney",
//                 "number": 3,
//                 "pos": "D",
//                 "grid": "2:2"
//               }
//             },
//             {
//               "player": {
//                 "id": 19959,
//                 "name": "B. White",
//                 "number": 4,
//                 "pos": "D",
//                 "grid": "2:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 1464,
//                 "name": "G. Xhaka",
//                 "number": 34,
//                 "pos": "M",
//                 "grid": "3:2"
//               }
//             },
//             {
//               "player": {
//                 "id": 1121,
//                 "name": "E. Smith Rowe",
//                 "number": 10,
//                 "pos": "M",
//                 "grid": "3:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 1427,
//                 "name": "A. Lokonga",
//                 "number": 23,
//                 "pos": "M",
//                 "grid": "4:3"
//               }
//             },
//             {
//               "player": {
//                 "id": 3246,
//                 "name": "N. Pépé",
//                 "number": 19,
//                 "pos": "M",
//                 "grid": "4:2"
//               }
//             },
//             {
//               "player": {
//                 "id": 138835,
//                 "name": "F. Balogun",
//                 "number": 26,
//                 "pos": "F",
//                 "grid": "4:1"
//               }
//             },
//             {
//               "player": {
//                 "id": 127769,
//                 "name": "Gabriel Martinelli",
//                 "number": 35,
//                 "pos": "M",
//                 "grid": "5:1"
//               }
//             }
//           ],
//           "substitutes": [
//             {
//               "player": {
//                 "id": 1460,
//                 "name": "B. Saka",
//                 "number": 7,
//                 "pos": "M",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 727,
//                 "name": "R. Nelson",
//                 "number": 24,
//                 "pos": "F",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 41377,
//                 "name": "Nuno Tavares",
//                 "number": 15,
//                 "pos": "D",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 1440,
//                 "name": "R. Holding",
//                 "number": 12,
//                 "pos": "D",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 1439,
//                 "name": "Bellerín",
//                 "number": 2,
//                 "pos": "D",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 1452,
//                 "name": "Mohamed Elneny",
//                 "number": 25,
//                 "pos": "M",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 190,
//                 "name": "Cédric Soares",
//                 "number": 17,
//                 "pos": "D",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 129295,
//                 "name": "K. Hein",
//                 "number": 49,
//                 "pos": "G",
//                 "grid": null
//               }
//             },
//             {
//               "player": {
//                 "id": 1456,
//                 "name": "A. Maitland-Niles",
//                 "number": 13,
//                 "pos": "M",
//                 "grid": null
//               }
//             }
//           ]
//         }
//       ],
//     ),
//   ));
// }
