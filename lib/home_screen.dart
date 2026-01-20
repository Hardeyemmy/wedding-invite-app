import 'package:flutter/material.dart';
import 'guest_book.dart';
import 'widgets.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'auth.dart';

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
            Image.asset('assets/pics.jpg', height: 100, width: 250),
            const SizedBox(height: 8.0),
            const IconAndText(Icons.calendar_month_rounded, 'Jan 25'),
            const IconAndText(Icons.location_city_sharp, 'Lagos, Nigeria'),
            Consumer<AppState>(
                builder: (context, auth, _) => Auth(
                    loggedIn: auth.loggedIn,
                    signOut: () {
                      FirebaseAuth.instance.signOut();
                    })),
            const SizedBox(height: 8.0),
            const Text('We are getting Married! Be Our Special Guest.'),
            Consumer<AppState>(
                builder: (context, auth, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (auth.loggedIn) ...[
                          const Text('Message for the Couple:'),
                          GuestBook(
                            addMessages: (message) =>
                                auth.addMessageToGuestBook(message),
                            messages: auth.guestBookMessages,
                          )
                        ]
                      ],
                    ))
          ],
        ),
      ),
    );
  }
}
