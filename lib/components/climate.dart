import 'package:flutter/material.dart';

class Climate extends StatelessWidget {
  final String temperature;

  const Climate({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Santa Maria da Codipi'),
        Text(
          '$temperature°C',
          style: TextStyle(fontSize: 65, fontWeight: FontWeight.w300),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [Text('Min Temp: 32°C'), Text('Máx Temp: 40°C')],
        ),
      ],
    );
  }
}
