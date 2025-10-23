import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  final String city;
  final String state;
  final DateTime updatedAt;

  const Header({
    super.key,
    required this.city,
    required this.state,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    String formatUpdatedAt() {
      final updatedAtFormated = DateFormat(
        'dd/MM/yyyy HH:mm',
      ).format(updatedAt);

      return updatedAtFormated;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$city, $state',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Atualizado em ${formatUpdatedAt()}'),
          ],
        ),
      ],
    );
  }
}
