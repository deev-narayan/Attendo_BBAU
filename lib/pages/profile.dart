import 'dart:convert';
import 'package:attendo/data/notifires.dart';
import 'package:attendo/pages/user_validation.dart';
import 'package:fl_chart/fl_chart.dart';

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
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: nameNotifier,
                  builder: (context, value, child) {
                    return Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: departmentNotifier,
                  builder: (context, value, child) {
                    return Text(
                      value.split(": ").first,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w200,
                      ),
                    );
                  },
                ),
              ],
            ),

            ValueListenableBuilder(
              valueListenable: departmentNotifier,
              builder: (context, value, child) {
                return Text(
                  value.split(": ").last,
                  style: TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
        leading: Container(
          padding: const EdgeInsets.all(5.0),
          child: ValueListenableBuilder<String>(
            valueListenable: profileImageNotifier,
            builder: (context, imgUrl, _) {
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // circular border
                  border: Border.all(
                    color: Color.fromARGB(113, 0, 132, 255), // border color
                    width: 2, // border width
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), // circular image
                  child: imgUrl.isNotEmpty && imgUrl != "Not Found"
                      ? Image.network(
                          imgUrl,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.colorBurn,
                        )
                      : Image.asset(
                          '',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                ),
              );
            },
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  width: 340,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time & Date
                          const Text(
                            "0:14:46 AM",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Monday",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                
                          // Class Info
                          const Text(
                            "Class running",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const Text(
                            "No Class Running",
                            style: TextStyle(fontSize: 16),
                          ),
                          const Text(
                            "Latitude: 26.770696\nLongitude: 80.9189773",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 25,
                            sections: [
                              PieChartSectionData(
                                color: Color.fromARGB(255, 0, 132, 255),
                                value: 80,
                                radius: 10,
                              ),
                              PieChartSectionData(
                                color: Color.fromARGB(255, 183, 220, 255),
                                value: 20,
                                radius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Container(
                  height: 50,
                  width: 340,
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
              const SizedBox(height: 5),
              // 🔹 Timetable + Percentage
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                    width: 340,

                    child: Center(
                      child: Column(
                        children: [
                          Card(
                            child: Container(
                              height: 20,
                              width: 300,

                              child: const Text("Percentage"),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Time Table",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 132, 255),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (timetable.isNotEmpty)
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: timetable.entries.map<Widget>((entry) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(entry.key),
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
                ),
              ),

              const SizedBox(height: 5),

              // 🔹 Attendance Button
              
            ],
          ),
        ),
      ),
    );
  }
}
