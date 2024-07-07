import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUICK TASKS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QUICK TASKS'),
        backgroundColor: Colors.blue, // Başlık kısmını mavi yapar
      ),
      body: Center(
        child: Text(
          'Welcome to QUICK TASKS!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
