import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = event['time']?['elapsed'] ?? 0;
    final extraTime = event['time']?['extra'];
    final team = event['team'] ?? {};
    final player = event['player'] ?? {};
    final assist = event['assist'] ?? {};
    final type = event['type'] ?? "Event";
    final detail = event['detail'] ?? "";

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Team logo
                if (team['logo'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      team['logo'],
                      height: 40.0,
                      width: 40.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 40),
                    ),
                  ),
                const SizedBox(width: 10.0),
                // Team name and time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        team['name'] ?? 'Unknown Team',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '$time${extraTime != null ? "+$extraTime" : ""}\'',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Event type icon
                Icon(
                  type == "Goal" ? Icons.sports_soccer : Icons.event,
                  color: type == "Goal"
                      ? Colors.green
                      : const Color(0xFF013084),
                  size: 30.0,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            // Player and event detail
            Text(
              type == "Goal"
                  ? "⚽ Goal by: ${player['name'] ?? 'Unknown Player'}"
                  : "$type: ${player['name'] ?? 'Unknown Player'}",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            if (assist['name'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  "🅰️ Assist: ${assist['name']}",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            if (detail.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
