import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'app_state.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      builder: (context, child) => const MyApp(),
    ),
  );
}

final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  GoRoute(
      path: 'sign-in',
      builder: (context, state) {
        return SignInScreen(actions: [
          ForgotPasswordAction(((context, email) {
            final uri = Uri(
                path: '/sign-in/forgot-password',
                queryParameters: <String, String?>{'email': email});
            context.push(uri.toString());
          })),
          AuthStateChangeAction(((context, state) {
            if (state is SignedIn || state is UserCreated) {
              var user = (state is SignedIn)
                  ? state.user
                  : (state as UserCreated).credential.user;
              if (user == null) {
                return;
              }
              if (state is UserCreated) {
                user.updateDisplayName(user.email?.split('@')[0]);
              }
              if (!user.emailVerified) {
                user.sendEmailVerification();
                const snackBar = SnackBar(
                    content: Text('Please verify your email address.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              context.pushReplacement('/');
            }
          }))
        ]);
      },
      routes: [
        GoRoute(
            path: 'forgot-password',
            builder: (context, state) {
              final argument = state.uri.queryParameters;
              return ForgotPasswordScreen(
                email: argument['email'],
                headerMaxExtent: 200,
              );
            })
      ]),
  GoRoute(
      path: 'profile',
      builder: (context, state) {
        return ProfileScreen(
          providers: const [],
          actions: [
            SignedOutAction((context) {
              context.pushReplacement('/');
            })
          ],
        );
      })
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding Invitation',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.notoSansTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
