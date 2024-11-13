import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/add_page.dart';
import '../pages/chat_page.dart';
import '../pages/profile_page.dart';
import '../design/colors.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AddPage(),
    const ChatPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: accentColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: NavigationBar(
              backgroundColor: accentColor,
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: allDestinations.map<NavigationDestination>(
                    (Destination destination) {
                  final bool isSelected = destination.index == selectedIndex;
                  return NavigationDestination(
                    icon: isSelected
                        ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        destination.icon,
                        color: accentColor,
                        size: 40,
                      ),
                    )
                        : Icon(
                      destination.icon,
                      color: whiteColor,
                      size: 40,
                    ),
                    label: destination.title,
                  );
                },
              ).toList(),
              indicatorColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon);
  final int index;
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination(0, '', Icons.home),
  Destination(1, '', Icons.playlist_add_rounded),
  Destination(2, '', Icons.sms_rounded),
  Destination(3, '', Icons.person),
];