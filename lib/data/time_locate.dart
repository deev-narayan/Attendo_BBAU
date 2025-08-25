import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class RealtimeInfo extends StatefulWidget {
  const RealtimeInfo({super.key});

  @override
  State<RealtimeInfo> createState() => _RealtimeInfoState();
}

class _RealtimeInfoState extends State<RealtimeInfo>{
  String _day = "--";
  String _time = "--:--:--";
  String _lat = "--";
  String _lng = "--";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startClock();
    _getLocation();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      setState(() {
        _day = DateFormat('EEEE').format(now);      // Monday, Tuesday...
        _time = DateFormat('h:mm:ss a').format(now); // 01:23:45 AM
      });
    });
  }

  Future<void> _getLocation() async {
    try {
      // request permissions if not granted
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      setState(() {
        _lat = pos.latitude.toStringAsFixed(6);
        _lng = pos.longitude.toStringAsFixed(6);
      });
    } catch (e) {
      setState(() {
        _lat = "Error";
        _lng = "Error";
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time & Date
        Text(
          _time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _day,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Class Info (your original text)
        const Text(
          "Class running",
          style: TextStyle(color: Colors.grey, fontSize: 8),
        ),
        const Text(
          "No Class Running",
          style: TextStyle(fontSize: 12),
        ),

        // Location
        Text(
          "Latitude: $_lat\nLongitude: $_lng",
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
