import 'package:attendo/pages/profile.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(19, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(90, 0, 0, 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "./assets/images/hero.png",
                  height: 150,
                  color: const Color.fromARGB(255, 0, 132, 255), // your desired color
                  colorBlendMode: BlendMode.srcIn,
                ),
                Container(
                  height: 230,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // Normal Text Input
                      SizedBox(
                        width: 260,
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: "Enrollment ID:",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Password Input
                      SizedBox(
                        width: 260,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true, // hides the text
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                      ),
                      SizedBox(height: 17),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return SafeArea(child: Profile());
                              },
                            ),
                          );
                        },
                        child: Text("Login", style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
