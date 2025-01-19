import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({
    super.key,
    required this.events,
  });

  final dynamic events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final elapsedTime = event["time"]["elapsed"];
          final teamName = event["team"]["name"];
          final teamLogo = event["team"]["logo"];
          final playerName = event["player"]["name"];
          final assistName = event["assist"]["name"];
          final eventType = event["type"];
          return GameEventsCard(
            teamLogo: teamLogo,
            playerName: playerName,
            assistName: assistName,
            teamName: teamName,
            elapsedTime: elapsedTime,
            eventType: eventType,
          );
        },);
  }
}

class GameEventsCard extends StatelessWidget {
  const GameEventsCard({
    super.key,
    required this.teamLogo,
    required this.playerName,
    required this.assistName,
    required this.teamName,
    required this.elapsedTime,
    required this.eventType,
  });

  final dynamic teamLogo;
  final dynamic playerName;
  final dynamic assistName;
  final dynamic teamName;
  final dynamic elapsedTime;
  final dynamic eventType;

  @override
  Widget build(BuildContext context) {
    String type = eventType == "Goal"
        ? "⚽ Goal $teamName at $elapsedTime'"
        : "Substitution at $elapsedTime'";
    String assist =
        type == "Goal" ? "Assist: $assistName" : "Sub out $assistName";

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      shadowColor: const Color.fromARGB(255, 129, 129, 129),
      color: const Color.fromARGB(189, 0, 0, 0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: teamLogo != null
              ? Image.network(
                  teamLogo,
                  height: 25,
                  width: 25,
                  fit: BoxFit.fill,
                )
              : const Icon(
                  Icons.sports_soccer,
                  color: Colors.grey,
                  size: 25,
                ),
          title: Text(
            playerName,
            style: const TextStyle(
              fontSize: 14.0,
              color: Color.fromARGB(255, 220, 220, 220),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (assistName != null && assistName.isNotEmpty)
                Text(
                  assist,
                  style: const TextStyle(color: Colors.grey),
                ),
              const SizedBox(
                height: 5,
              ),
              Text(
                type,
                style:
                    const TextStyle(color: Color.fromARGB(255, 113, 145, 162)),
              ),
            ],
          ),
          trailing: Text(
            "$elapsedTime'",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              color: Color.fromARGB(137, 216, 216, 216),
            ),
          ),
        ),
      ),
    );
  }
}
