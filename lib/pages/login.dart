import 'package:attendo/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:attendo/styles/app_color.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(94, 71, 71, 71),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(40, 150, 40, 150),
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: MediaQuery.of(context).size.height - 300,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(92, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(90, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return Profile();
                    },
                  ),
                );
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
