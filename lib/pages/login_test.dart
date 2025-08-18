import 'dart:convert';
import 'dart:io';

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
  late final WebViewController _controller;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isLoggedIn = false;
  Map<String, dynamic> userData = {
    "name": "",
    "department": "",
    "profileImage": "",
  };

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            // detect profile page load
            if (url.contains("vidhyarthi/profile/index")) {
              debugPrint("✅ Profile page loaded");

              final data = await extractProfileInfo();
              if (!mounted) return;

              setState(() {
                userData = data;
                isLoading = false;
                isLoggedIn = true;
              });

              // ✅ Delay saving JSON until after the first frame
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                await saveToJson(data);

                // Navigate only if profile is valid
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

  /// Inject username + password into login form and click submit
  Future<void> _injectJS() async {
    await _controller.runJavaScript('''
      document.querySelector('input[name="LoginForm[username]"]').value = "${usernameController.text}";
      document.querySelector('input[name="LoginForm[password]"]').value = "${passwordController.text}";
      var loginbutton = document.querySelector('#login-form button[type="submit"]');
      if(loginbutton) loginbutton.click();
    ''');
  }

  /// Navigate to profile page
  Future<void> gotoprofile() async {
    await _controller.runJavaScript('''
      window.location.href = 'https://bbau.samarth.edu.in/index.php/vidhyarthi/profile/index';
    ''');
  }

  /// Extract profile info (name, dept, image)
  Future<Map<String, dynamic>> extractProfileInfo() async {
    try {
      String name =
          await _controller.runJavaScriptReturningResult('''
        (() => {
          var elem = document.querySelector("body > div.be-wrapper.be-fixed-sidebar > div.be-content > div > div:nth-child(3) > div > div > div:nth-child(1) > div > div.col-md-9.col-sm-12 > strong");
          return elem ? elem.textContent.trim() : "Not Found";
        })();
      ''')
              as String;

      String department =
          await _controller.runJavaScriptReturningResult('''
        (() => {
          var elem = document.querySelector("body > div.be-wrapper.be-fixed-sidebar > div.be-content > div > div:nth-child(4) > div > div > div.card-body.table-responsive > div > div > div.card-header.text-uppercase > h5");
          return elem ? elem.textContent.trim() : "Not Found";
        })();
      ''')
              as String;

      String profileImage =
          await _controller.runJavaScriptReturningResult('''
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

  /// Save JSON to local file
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
            // Hidden WebView (set height >0 for debugging)
            Positioned(
              height: 0,
              width: 0,
              child: WebViewWidget(controller: _controller),
            ),

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
                  : Container(
                    height: 470,
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
                      
                            // Enrollment ID input
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
                      
                            // Password input
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
                      
                            const SizedBox(height: 20),
                      
                            // Login Button
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
                      
                                  // Inject login
                                  await _injectJS();
                      
                                  // After login, explicitly go to profile page
                                  Future.delayed(const Duration(seconds: 3), () {
                                    gotoprofile();
                                  });
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                      
                            const SizedBox(height: 20),
                            Text("Status: ${userData["department"]}"),
                            
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
