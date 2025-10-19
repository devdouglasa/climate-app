import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final Map<String, dynamic> params = {
    "latitude": "-4.99257221989724",
    "longitude": "-42.83426770514146",
    "timezone": "auto",
    "current_weather": "true",
    "hourly": "temperature_2m",
    "forecast_hours": "4",
  };

  Future<Map<String, dynamic>> getClimate() async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', params);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      return throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }
}
