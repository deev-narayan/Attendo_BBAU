import 'dart:ui';

import 'package:attendo/pages/user_validation.dart';
import 'package:attendo/styles/app_color.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(14, 226, 226, 226),
              ),
              child: Center(
                child: Text(
                  "B.Tech : Computer Science Engineering",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w100),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 410,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(31, 255, 255, 255),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100), // circle
                          child: Image.asset(
                            'assets/images/prof.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 20),

                        Column(
                          children: [
                            Text("Divyansh Kumar", textAlign: TextAlign.left),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Text("Semester: 3rd"),
                                SizedBox(width: 7),
                                Text("/"),
                                SizedBox(width: 7),
                                Text("Year: 2nd"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 500,
              width: 410,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(31, 255, 255, 255),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 410,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(31, 255, 255, 255),
              ),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return UserValidation();
                      }),
                    ),
                  );
                },
                child: Text("Mark your attendace"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
