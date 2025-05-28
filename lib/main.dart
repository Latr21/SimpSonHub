import 'package:flutter/material.dart';
import 'route/app_router.dart';

void main() {
  runApp(const SimpSonHubApp());
}

class SimpSonHubApp extends StatelessWidget {
  const SimpSonHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpSonHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: appRoutes, // <- c’est ça qui relie les routes
    );
  }
}