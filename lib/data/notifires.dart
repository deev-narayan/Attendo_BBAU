import 'package:flutter/material.dart';

ValueNotifier<String> nameNotifier = ValueNotifier("");
ValueNotifier<String> departmentNotifier = ValueNotifier("");
ValueNotifier<String> profileImageNotifier = ValueNotifier("");
ValueNotifier<int?> yearNotifier = ValueNotifier(null);
ValueNotifier<int?> semesterNotifier = ValueNotifier(null);
ValueNotifier<int> selectPage = ValueNotifier<int>(0);
