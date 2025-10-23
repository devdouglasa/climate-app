import 'package:flutter/material.dart';

class Climate extends StatelessWidget {
  final String temperature;
  final String street;
  final double temperatureMin;
  final double temperatureMax;

  const Climate({
    super.key,
    required this.temperature,
    required this.street,
    required this.temperatureMin,
    required this.temperatureMax,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(street),
        Text(
          '$temperature°C',
          style: TextStyle(fontSize: 65, fontWeight: FontWeight.w300),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text('Min Temp: ${temperatureMin.toInt()}°C'),
            Text('Máx Temp: ${temperatureMax.toInt()}°C'),
          ],
        ),
      ],
    );
  }
}
