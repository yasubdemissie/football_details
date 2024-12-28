import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = "06193126e7dc6ded03be176a16189061";
var headers = {
  'x-rapidapi-key': apiKey,
  'x-rapidapi-host': 'v3.football.api-sports.io'
};

Future<Map<String, dynamic>> fetchData() async {
  const url = "https://v3.football.api-sports.io/fixtures?live=all";

  try {
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Error fetching data: $error');
  }
}

Future<Map<String, dynamic>> fetchLeagueFixtures(
    String leagueId, String season) async {
  final url =
      "https://v3.football.api-sports.io/fixtures?league=$leagueId&season=$season";

  try {
    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  } catch (error) {
    throw Exception('Error fetching data: $error');
  }
}

Future<Map<String, dynamic>> fetchPremierLeagueFixtures(String season) async {
  return await fetchLeagueFixtures("39", season);
}

Future<Map<String, dynamic>> fetchChampionsLeagueFixtures(String season) async {
  return await fetchLeagueFixtures("2", season);
}

Future<Map<String, dynamic>> fetchAsianCupFixtures(String season) async {
  return await fetchLeagueFixtures("7", season);
}

Future<Map<String, dynamic>> fetchGameDetails(int fixtureId) async {
  final url = "https://v3.football.api-sports.io/fixtures?id=$fixtureId";

  const header = {
    'x-rapidapi-key': apiKey,
    'x-rapidapi-host': 'v3.football.api-sports.io'
  };

  var response = await http.get(Uri.parse(url), headers: headers);
  var data = jsonDecode(response.body);

  return data;
}
