import 'package:attendo/data/notifires.dart';
import 'package:attendo/pages/overviewpage.dart';
import 'package:attendo/pages/profile.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Reset to index 0 whenever WidgetTree loads
    if (selectPage.value != 0) {
      selectPage.value = 0;
    }

    final List<Widget> pages = const [
      Profile(),
      Overviewpage(),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: selectPage,
      builder: (context, selectedPage, child) {
        return Scaffold(
          body: pages[selectedPage],
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
              NavigationDestination(icon: Icon(Icons.dashboard), label: "Overview"),
            ],
            selectedIndex: selectedPage,
            onDestinationSelected: (value) {
              selectPage.value = value;
            },
          ),
        );
      },
    );
  }
}
