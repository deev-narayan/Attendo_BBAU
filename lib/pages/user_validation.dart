import 'dart:io';

import 'package:attendo/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class UserValidation extends StatefulWidget {
  const UserValidation({super.key});

  @override
  State<UserValidation> createState() => _UserValidationState();
}

class _UserValidationState extends State<UserValidation> {
  CameraController controller = CameraController(
    cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    ),
    ResolutionPreset.high,
  );

  int selectedCameraIndex = 2;
  bool isInitialized = false;
  bool permissionGranted = false;

  bool cameraopen = false;
  @override
  void initState() {
    super.initState();
    requestCameraPermission();
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      permissionGranted = true;
      initializeCamera(selectedCameraIndex);
    } else {
      setState(() {
        permissionGranted = false;
      });
    }
  }

  void initializeCamera(int index) async {
    try {
      await controller.initialize();
      setState(() {
        isInitialized = true;
        selectedCameraIndex = index;
      });
    } catch (e) {
      print('Camera error: $e');
    }
  }

  Future<void> takePicture(BuildContext context) async {
    if (!controller.value.isInitialized) return;

    final directory = Directory('/storage/emulated/0/Pictures/CameraApp');
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final path = join(directory.path, 'IMG_$timestamp.png');
    await File(path).create(recursive: true);

    try {
      await controller.takePicture().then((file) {
        file.saveTo(path);
        print("pricture clicked");
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) {}),
        // );
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  void switchCamera() async {
    await controller.dispose();
    final newIndex = (selectedCameraIndex + 1) % cameras.length;

    setState(() {
      isInitialized = false;
    });

    initializeCamera(newIndex);
  }

  @override
  void dispose() {
    if (controller.value.isInitialized) {
      controller.dispose();
    }
    super.dispose();
  }

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
                                color: Color.fromARGB(255, 0, 132, 255),
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
                                color: Color.fromARGB(255, 0, 132, 255),
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
                                      color: Color.fromARGB(255, 0, 132, 255),
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
                                      color: Color.fromARGB(255, 0, 132, 255),
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
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 132, 255),
                                ),
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
                                color: Color.fromARGB(255, 0, 132, 255),
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
                                color: Color.fromARGB(255, 0, 132, 255),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: isInitialized
                              ? AspectRatio(
                                  aspectRatio: 1,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width:
                                          controller.value.previewSize!.height,
                                      height:
                                          controller.value.previewSize!.width,
                                      child: CameraPreview(controller),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              maximumSize: Size(180, 50),
                              minimumSize: Size(180, 50),
                              side: BorderSide(
                                color: Color.fromARGB(255, 0, 132, 255),
                                width: 1, // optional: thickness
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            onPressed: () {
                              print("Opening camera");
                              setState(() {});
                              print(
                                "Camera 111111111 ${controller.description.name}",
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.camera_alt,
                                  color: const Color.fromRGBO(233, 233, 233, 1),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Switch Camera",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 132, 255),
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
