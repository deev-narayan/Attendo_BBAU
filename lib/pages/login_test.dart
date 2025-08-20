import 'dart:convert';
import 'dart:io';

import 'package:attendo/data/notifires.dart';
import 'package:attendo/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginTest extends StatefulWidget {
  const LoginTest({super.key});

  @override
  State<LoginTest> createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  WebViewController? _controller; // nullable
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSavedProfile();
  }

  // Load saved profile.json if exists
  Future<Map<String, dynamic>?> loadSavedProfile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/profile.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        return jsonDecode(content);
      }
    } catch (e) {
      debugPrint("❌ Error loading saved profile: $e");
    }
    return null;
  }

  // Check saved profile or initialize WebView
  Future<void> _checkSavedProfile() async {
    final savedData = await loadSavedProfile();
    if (savedData != null && savedData["name"] != "") {
      // update notifiers with saved data
      nameNotifier.value = savedData["name"];
      departmentNotifier.value = savedData["department"];
      profileImageNotifier.value = savedData["profileImage"];

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SafeArea(child: Profile()),
        ),
      );
    } else {
      // Initialize WebView for first-time login
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (url) async {
              if (url.contains("vidhyarthi/profile/index")) {
                debugPrint("✅ Profile page loaded");

                final data = await extractProfileInfo();
                if (!mounted) return;

                nameNotifier.value = data["name"];
                departmentNotifier.value = data["department"];
                profileImageNotifier.value = data["profileImage"];

                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await saveToJson(data);
                  if (data["name"] != "Not Found" && mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SafeArea(child: Profile()),
                      ),
                    );
                  }
                });
              }
            },
          ),
        )
        ..loadRequest(
          Uri.parse('https://bbau.samarth.edu.in/index.php/site/login'),
        );
    }
  }

  // Inject login credentials
  Future<void> _injectJS() async {
    if (_controller == null) return;
    await _controller!.runJavaScript('''
      document.querySelector('input[name="LoginForm[username]"]').value = "${usernameController.text}";
      document.querySelector('input[name="LoginForm[password]"]').value = "${passwordController.text}";
      var loginbutton = document.querySelector('#login-form button[type="submit"]');
      if(loginbutton) loginbutton.click();
    ''');
  }

  // Go to profile page after login
  Future<void> gotoprofile() async {
    if (_controller == null) return;
    await _controller!.runJavaScript('''
      window.location.href = 'https://bbau.samarth.edu.in/index.php/vidhyarthi/profile/index';
    ''');
  }

  // Extract profile info
  Future<Map<String, dynamic>> extractProfileInfo() async {
    if (_controller == null)
      return {
        "name": "Not Found",
        "department": "Not Found",
        "profileImage": "Not Found",
      };
    try {
      String name =
          await _controller!.runJavaScriptReturningResult('''
        (() => {
          var elem = document.querySelector("body > div.be-wrapper.be-fixed-sidebar > div.be-content > div > div:nth-child(3) > div > div > div:nth-child(1) > div > div.col-md-9.col-sm-12 > strong");
          return elem ? elem.textContent.trim() : "Not Found";
        })();
      ''')
              as String;

      String department =
          await _controller!.runJavaScriptReturningResult('''
        (() => {
          var elem = document.querySelector("body > div.be-wrapper.be-fixed-sidebar > div.be-content > div > div:nth-child(4) > div > div > div.card-body.table-responsive > div > div > div.card-header.text-uppercase > h5");
          return elem ? elem.textContent.trim() : "Not Found";
        })();
      ''')
              as String;

      String profileImage =
          await _controller!.runJavaScriptReturningResult('''
        (() => {
          var elem = document.querySelector("body > div.be-wrapper.be-fixed-sidebar > div.be-content > div > div:nth-child(3) > div > div > div:nth-child(1) > div > div.col-md-3.col-sm-12 > img");
          return elem ? elem.src : "Not Found";
        })();
      ''')
              as String;

      return {
        "name": name.replaceAll('"', ''),
        "department": department.replaceAll('"', ''),
        "profileImage": profileImage.replaceAll('"', ''),
      };
    } catch (e) {
      debugPrint("❌ Error extracting profile: $e");
      return {
        "name": "Not Found",
        "department": "Not Found",
        "profileImage": "Not Found",
      };
    }
  }

  // Save profile locally
  Future<void> saveToJson(Map<String, dynamic> data) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/profile.json');
      await file.writeAsString(jsonEncode(data));
      debugPrint("✅ Saved profile at ${file.path}");
    } catch (e, st) {
      debugPrint("❌ Error saving JSON: $e\n$st");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Hidden WebView
            if (_controller != null)
              Positioned(
                height: 0,
                width: 0,
                child: WebViewWidget(controller: _controller!),
              ),

            // Login UI
            Center(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Fetching your profile, please wait..."),
                      ],
                    )
                  : SizedBox(
                      height: 430,
                      width: 340,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "./assets/images/hero.png",
                              height: 150,
                              color: const Color.fromARGB(255, 0, 132, 255),
                              colorBlendMode: BlendMode.srcIn,
                            ),
                            const SizedBox(height: 30),

                            // Username
                            SizedBox(
                              width: 260,
                              child: TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  labelText: "Enrollment ID",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Password
                            SizedBox(
                              width: 260,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Login button
                            Container(
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 0, 132, 255),
                                  width: 2,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  setState(() => isLoading = true);
                                  await _injectJS();
                                  Future.delayed(
                                    const Duration(seconds: 3),
                                    () {
                                      gotoprofile();
                                    },
                                  );
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 16),
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
    );
  }
}

// Optional: Add this logout function in Profile.dart
Future<void> logout(BuildContext context) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/profile.json');
  if (await file.exists()) await file.delete();

  Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (context) => const LoginTest()));
}
