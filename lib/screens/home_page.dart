import 'package:climate_app/components/card_prevision.dart';
import 'package:climate_app/components/climate.dart';
import 'package:climate_app/components/header.dart';
import 'package:climate_app/services/climate_location.dart';
import 'package:climate_app/services/weather_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: ClimateLocation().getClimateLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('Nenhum dado disponível'));
          }

          final data = snapshot.data!;
          final double currentTemp =
              data['climate']['current_weather']['temperature'];
          final DateTime updatedAtData = DateTime.parse(
            data['climate']['current_weather']['time'],
          );
          final Map<String, dynamic> listHourly = data['climate']['hourly'];
          final List<dynamic> times = listHourly['time'];
          final List<dynamic> temps = listHourly['temperature_2m'];
          final double tempMinData =
              data['climate']['daily']['temperature_2m_min'][0];
          final double tempMaxData =
              data['climate']['daily']['temperature_2m_max'][0];
          final int precipitation = listHourly['precipitation_probability'][0];
          final List<Widget> cards = [];

          for (int i = 0; i < times.length; i++) {
            final time = DateTime.parse(times[i]);
            final double temp = temps[i];

            final tempConverted = temp.toInt().toString();

            cards.add(CardPrevision(temperature: tempConverted, time: time));
          }

          final String cityData = data['location']['locality'];
          final String stateData = data['location']['administrativeArea'];
          final String streetData = data['location']['street'];

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 0, 24, 94),
                  Color.fromARGB(255, 97, 0, 126),
                  Color.fromARGB(255, 67, 0, 88),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Header
                Header(
                  city: cityData,
                  state: stateData,
                  updatedAt: updatedAtData,
                ),
                // Climate
                Climate(
                  temperature: currentTemp.toInt().toString(),
                  street: streetData,
                  temperatureMin: tempMinData,
                  temperatureMax: tempMaxData,
                ),
                // Card Prevision
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: cards,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
