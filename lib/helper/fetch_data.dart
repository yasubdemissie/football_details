import 'package:http/http.dart' as http;
import 'dart:convert';

// const String apiKey1 = "06193126e7dc6ded03be176a16189061";
// const String apiKey1 = "bebe7761f9b40e3390bf3a92d111cfe2";
// const String apiKey1 = "a2730bc99f110dba8e97453d97b5b050";
// const String apiKey1 = "8150a98d75302815b7a48d1bc2eac39b";
// const String apiKey1 = "1a46a738ce45c894575cd3875578c1fc";
const String apiKey1 = "951f0a823c951fbaad70c02612717f83";
// const String apiKey2 = "920662209038eaa9e621185aa478ae6b";
// const String apiKey3 = "6a81f07656msh75afaa78f557fe1p1fd5ddjsnee70b3f10fb";

const url1 = "https://v3.football.api-sports.io";
const url2 = "https://api-football-v1.p.rapidapi.com/v3";

var headers = {
  'x-rapidapi-key': apiKey1,
  'x-rapidapi-host': url1,
};

Future<Map<String, dynamic>> fetchData() async {
  const url = "$url1/fixtures?live=all";

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
  final url = "$url1/fixtures?league=$leagueId&season=$season";

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
  final url = "$url1/fixtures?id=$fixtureId";

  var response = await http.get(Uri.parse(url), headers: headers);
  var data = jsonDecode(response.body);

  return data;
}
