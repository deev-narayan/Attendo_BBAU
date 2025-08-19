import 'dart:ui';
import 'dart:convert';
import 'package:attendo/data/notifires.dart';
import 'package:attendo/pages/user_validation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic> timetable = {};
  String today = DateFormat('EEEE').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    String data = await rootBundle.loadString('assets/data/timetable.json');
    var todaystimetable = json.decode(data)["timetable"][today.toLowerCase()];
    setState(() {
      timetable = todaystimetable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Department banner
            ValueListenableBuilder<String>(
              valueListenable: departmentNotifier,
              builder: (context, dept, _) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 50,
                  width: 340,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(106, 0, 132, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      dept.isNotEmpty ? dept : "Department not available",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // 🔹 Profile card
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(61, 187, 182, 182),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🔹 Profile image
                        ValueListenableBuilder<String>(
                          valueListenable: profileImageNotifier,
                          builder: (context, imgUrl, _) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: imgUrl.isNotEmpty && imgUrl != "Not Found"
                                  ? Image.network(
                                      imgUrl,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/prof.png',
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                            );
                          },
                        ),

                        // 🔹 Name + semester + year
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ValueListenableBuilder<String>(
                              valueListenable: nameNotifier,
                              builder: (context, name, _) {
                                return Text(
                                  name.isNotEmpty ? name : "No Name",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: const [
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

            const SizedBox(height: 10),

            // 🔹 Timetable + Percentage
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(61, 187, 182, 182),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        width: 300,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(61, 187, 182, 182),
                        ),
                        child: const Text("Percentage"),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text("Time Table"),
                        ),
                      ),
                      if (timetable.isNotEmpty)
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: timetable.entries.map<Widget>((entry) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(entry.key),
                                Text("${entry.value}"),
                              ],
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Attendance Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Container(
                height: 50,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(61, 187, 182, 182),
                  border: Border.all(
                    width: 2,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UserValidation(),
                      ),
                    );
                  },
                  child: const Text(
                    "Mark your attendance",
                    style: TextStyle(fontWeight: FontWeight.w600),
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
