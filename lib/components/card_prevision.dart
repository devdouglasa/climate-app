import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPrevision extends StatelessWidget {
  final String temperature;
  final DateTime time;

  const CardPrevision({
    super.key,
    required this.temperature,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final hour = DateFormat('HH:mm').format(time);

    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(71, 255, 255, 255),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: Size.fromHeight(85),
          ),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 6,
            children: [
              Icon(
                time.hour >= 18 ? Icons.nightlight_round : Icons.sunny,
                color: Colors.yellow,
                size: 25,
              ),
              Column(
                spacing: 3,
                children: [
                  Text(
                    '$temperature°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(hour, style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
