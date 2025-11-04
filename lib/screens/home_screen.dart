import 'package:climate_app/components/card_prevision.dart';
import 'package:climate_app/components/climate.dart';
import 'package:climate_app/components/header.dart';
import 'package:climate_app/services/climate_location.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

          final String cityData = data['location']['locality'] == ""
              ? data['location']['subLocality']
              : data['location']['locality'];
          final String stateData = data['location']['administrativeArea'];
          final String streetData = data['location']['street'];

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                  // Color.fromARGB(255, 0, 24, 94),
                  // Color.fromARGB(255, 48, 0, 126),
                  // Color.fromARGB(255, 67, 0, 88),
                ],
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                  Column(
                    spacing: 17,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Probabilidade de Chuva: $precipitation%',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: cards,
                          ),
                        ),
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
