import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const BintangHarianApp());
}

class BintangHarianApp extends StatelessWidget {
  const BintangHarianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bintang Harian',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}