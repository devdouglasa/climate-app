import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApi {
  final Map<String, dynamic> params = {
    "latitude": "",
    "longitude": "",
    "timezone": "auto",
    "current_weather": "true",
    "hourly": "temperature_2m,precipitation_probability",
    "daily": "temperature_2m_min,temperature_2m_max",
    "forecast_hours": "4",
  };

  Future<Map<String, dynamic>> getClimate(double latitude, double longitude) async {
    params['latitude'] = latitude.toString();
    params['longitude'] = longitude.toString();

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
