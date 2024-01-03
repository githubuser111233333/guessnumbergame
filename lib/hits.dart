import 'dart:convert';
import 'package:http/http.dart' as http;

class Hits {
  final int playerId;
  final int totalHits;
  final int attempts;

  Hits({
    required this.playerId,
    required this.totalHits,
    required this.attempts,
  });

  factory Hits.fromJson(Map<String, dynamic> json) {
    return Hits(
      playerId: int.parse(json['playerId']),
      totalHits: int.parse(json['totalHits']),
      attempts: int.parse(json['attempts']),
    );
  }


  static Future<List<Hits>> fetchHits() async {
    final response = await http.get(Uri.parse('https://guessnumber1.000webhostapp.com/get_hits.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Hits.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hits');
    }
  }
}

