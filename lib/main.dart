import 'package:flutter/material.dart';
import 'package:havadurumu/screens/HomePage.dart';
void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}