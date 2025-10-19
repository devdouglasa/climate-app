import 'package:climate_app/components/card_prevision.dart';
import 'package:climate_app/components/climate.dart';
import 'package:climate_app/components/header.dart';
import 'package:climate_app/services/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: api.getClimate(),
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
          final double currentTemp = data['current_weather']['temperature'];
          final Map<String, dynamic> listHourly = data['hourly'];

          final List<dynamic> times = listHourly['time'];
          final List<dynamic> temps = listHourly['temperature_2m'];

          final List<Widget> cards = [];

          for (int i = 0; i < times.length; i++) {
            final time = DateTime.parse(times[i]);
            final double temp = temps[i];

            final tempConverted = temp.toInt().toString();
            
            cards.add(CardPrevision(temperature: tempConverted, time: time));
          }

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
                Header(),
                // Climate
                Climate(temperature: currentTemp.toInt().toString()),
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
