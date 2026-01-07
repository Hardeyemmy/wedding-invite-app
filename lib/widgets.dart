import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  const IconAndText(this.icon, this.text, {super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24.0, color: Colors.black),
          const SizedBox(width: 7.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
