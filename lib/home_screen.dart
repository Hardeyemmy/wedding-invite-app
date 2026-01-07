import 'package:flutter/material.dart';
import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Be Our Guest on our Special Day'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/pics.jpg', height: 350, width: 350),
            const SizedBox(height: 8.0),
            const IconAndText(Icons.calendar_month_rounded, 'Jan 25'),
            const IconAndText(Icons.location_city_sharp, 'Lagos, Nigeria'),
            const SizedBox(height: 8.0),
            const Text('We are getting Married! Be Our Special Guest.'),
          ],
        ),
      ),
    );
  }
}
