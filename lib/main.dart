import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';

import 'providers/home_provider.dart';

import 'screens/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: "PA System",

        theme: ThemeData(
          primaryColor: const Color(0xFF6FE7DD),

          scaffoldBackgroundColor: Colors.white,
        ),

        home: const LoginScreen(),
      ),
    );
  }
}
