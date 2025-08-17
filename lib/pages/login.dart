import 'package:attendo/pages/profile.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(94, 71, 71, 71),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  height: 450,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(92, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(90, 0, 0, 0),
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return Profile();
                        },
                      ),
                    );
                  },
                  child: Text("login"),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("./assets/images/hero.png", height: 150),
              Container(
                height: 240,
                child: Column(
                  children: [
                    TextField(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
