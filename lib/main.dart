import 'package:attendo/pages/login.dart';
import 'package:attendo/styles/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 0, 132, 255),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Login(),
    );
  }
}
