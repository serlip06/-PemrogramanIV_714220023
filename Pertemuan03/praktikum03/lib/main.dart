import 'package:flutter/material.dart';
import 'package:praktikum03/material_app.dart';


void main() {
  runApp( AppMaterial());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
