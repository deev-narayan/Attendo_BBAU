import 'dart:ui';
import 'dart:convert';
import 'package:attendo/pages/user_validation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart'; // Add this import for DateFormat

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> timetable = {};

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  String today = DateFormat('EEEE').format(DateTime.now());
  Future<void> loadJson() async {
    String data = await rootBundle.loadString('assets/data/timetable.json');
    var todaystimetable = json.decode(data)["timetable"][today.toLowerCase()];
    print(today.toLowerCase());
    setState(() {
      timetable = todaystimetable;
    });
  }

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
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color.fromARGB(255, 0, 132, 255),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "B.Tech : Computer Science Engineering",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Stack(
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(00, 20, 0, 20),
                      width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentGeometry.directional(00, 00),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color.fromARGB(255, 36, 149, 255),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  100,
                                ), // circle
                                child: Image.asset(
                                  'assets/images/prof.png',
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Divyansh Kumar",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Container(
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(12, 187, 182, 182),
                        ),
                        child: Text("Percentage"),
                      ),
                      SizedBox(height: 20),

                      if (timetable.isNotEmpty)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      "Time Table",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(
                                          255,
                                          36,
                                          149,
                                          255,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ListView(
                                  shrinkWrap:
                                      true, // 👈 tells ListView to take only the space it needs
                                  physics:
                                      NeverScrollableScrollPhysics(), // 👈 disable its own scrolling
                                  children: timetable.entries.map<Widget>((
                                    entry,
                                  ) {
                                    // return ListTile(
                                    //   title: Text("${entry.key} → ${entry.value}"),
                                    // );
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        5,
                                        0,
                                        0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${entry.key}"),
                                          Text("${entry.value}"),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Card(
                child: Container(
                  height: 50,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(
                      width: 2,
                      color: Color.fromARGB(255, 0, 132, 255),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return UserValidation();
                          }),
                        ),
                      );
                    },
                    child: Text(
                      "Mark your attendace",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
