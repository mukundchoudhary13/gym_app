import 'package:flutter/material.dart';
import 'package:gym_app/views/guide.dart';
import 'package:gym_app/views/timeline.dart';

import 'CreatePlan.dart';

class NavigatorBarPage extends StatefulWidget {
  const NavigatorBarPage({Key? key}) : super(key: key);

  @override
  State<NavigatorBarPage> createState() => _NavigatorBarPageState();
}

class _NavigatorBarPageState extends State<NavigatorBarPage> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  [
        Plan(),
        TimelinePage(),
        GuidePage()
      ][selectedPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.note_alt_sharp),
            icon: Icon(Icons.note_alt_outlined),
            label: 'Create Plan',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.timeline),
            icon: Icon(Icons.timeline_outlined),
            label: 'Timeline',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.diamond),
            icon: Icon(Icons.diamond_outlined),
            label: 'Guide',
          ),
        ],
      ),
    );

  }
}
