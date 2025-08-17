import 'package:flutter/material.dart';

class UserValidation extends StatefulWidget {
  const UserValidation({super.key});

  @override
  State<UserValidation> createState() => _UserValidationState();
}

class _UserValidationState extends State<UserValidation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Name ", style: TextStyle(fontSize: 16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  width: 350,

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: const Color(0xFFF06292),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Verify location",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 20),
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 400,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Longitude :"),
                                  Text(
                                    "111",
                                    style: TextStyle(
                                      color: Colors.pink.shade300,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Latiitude :"),
                                  Text(
                                    "11dfsd1",
                                    style: TextStyle(
                                      color: Colors.pink.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Distance From Class : ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "1 km",
                                style: TextStyle(color: Colors.pink[300]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: SizedBox(
                  width: 350,

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: const Color(0xFFF06292),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Verify Selfie",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 20),
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.pink[300],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              maximumSize: Size(180, 50),
                              minimumSize: Size(180, 50),
                              side: BorderSide(
                                color: Colors.pink[300]!,
                                width: 1, // optional: thickness
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: const Color.fromRGBO(233, 233, 233, 1),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Start Camera",
                                  style: TextStyle(
                                    color: Colors.pink[300],
                                    fontSize: 16,
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
