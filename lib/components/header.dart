import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Teresina, Piauí',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Atualizado em 19/10/2025 17:17'),
          ],
        ),
      ],
    );
  }
}
