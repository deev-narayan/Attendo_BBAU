import 'dart:io';

import 'package:attendo/pages/login.dart';
import 'package:attendo/pages/login_test.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Overviewpage extends StatefulWidget {
  const Overviewpage({super.key});

  @override
  State<Overviewpage> createState() => _OverviewpageState();
}

class _OverviewpageState extends State<Overviewpage> {
  Future<void> _logout(BuildContext context) async {
    try {
      // Get the app documents directory
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/profile.json";

      final file = File(filePath);

      if (await file.exists()) {
        await file.delete(); // ✅ remove profile.json
        debugPrint("profile.json deleted");
      } else {
        debugPrint("profile.json not found");
      }
    } catch (e) {
      debugPrint("Error deleting profile.json: $e");
    }

    // Navigate back to login and clear stack
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginTest()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: OutlinedButton(
          onPressed: () => _logout(context),
          child: Text("Logout"),
        ),
      ),
    );
  }
}
