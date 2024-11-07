import 'package:flutter/material.dart';

class AmPm extends StatelessWidget {
  final bool isItAm;

  const AmPm({super.key, required this.isItAm});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(isItAm == true ? 'am' : 'pm',
            style: const TextStyle(fontSize: 40, color: Colors.white)));
  }
}
