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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(color: const Color.fromARGB(94, 71, 71, 71)),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(40, 150, 40, 150),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(92, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(90, 0, 0, 0))
                )
              ),
            )
            
          ],
        ),
      ),
    );
  }
}
