import 'package:flutter/material.dart';
import 'home_page.dart';
import 'add_page.dart';
import 'chat_page.dart';
import 'profile_page.dart';
import '../colors.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with TickerProviderStateMixin<Navigation> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, '', Icons.home),
    Destination(1, '', Icons.playlist_add_rounded),
    Destination(2, '', Icons.sms_rounded),
    Destination(3, '', Icons.person),
  ];

  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  AnimationController buildFaderController() {
    final AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    controller.addStatusListener(
          (AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {}); // Rebuild unselected destinations offstage.
        }
      },
    );
    return controller;
  }

  @override
  void initState() {
    super.initState();

    navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      allDestinations.length,
          (int index) => GlobalKey(),
    ).toList();

    destinationFaders = List<AnimationController>.generate(
      allDestinations.length,
          (int index) => buildFaderController(),
    ).toList();
    destinationFaders[selectedIndex].value = 1.0;

    final CurveTween tween = CurveTween(curve: Curves.fastOutSlowIn);
    destinationViews = allDestinations.map<Widget>(
          (Destination destination) {
        return FadeTransition(
          opacity: destinationFaders[destination.index].drive(tween),
          child: DestinationView(
            destination: destination,
            navigatorKey: navigatorKeys[destination.index],
          ),
        );
      },
    ).toList();
  }

  @override
  void dispose() {
    for (final AnimationController controller in destinationFaders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        final NavigatorState navigator =
        navigatorKeys[selectedIndex].currentState!;
        navigator.pop();
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map(
                  (Destination destination) {
                final int index = destination.index;
                final Widget view = destinationViews[index];
                if (index == selectedIndex) {
                  destinationFaders[index].forward();
                  return Offstage(offstage: false, child: view);
                } else {
                  destinationFaders[index].reverse();
                  if (destinationFaders[index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              },
            ).toList(),
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
                          color: Colors.white,
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
                        color: Colors.white,
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

class DestinationView extends StatefulWidget {
  const DestinationView({
    super.key,
    required this.destination,
    required this.navigatorKey,
  });

  final Destination destination;
  final Key navigatorKey;

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) {
            switch (widget.destination.index) {
              case 0:
                return const HomePage();
              case 1:
                return const AddPage();
              case 2:
                return const ChatPage();
              case 3:
                return const ProfilePage();
            }
            assert(false);
            return const SizedBox();
          },
        );
      },
    );
  }
}

class NavigatorPopHandler extends StatelessWidget {
  final Widget child;
  final VoidCallback onPop;

  const NavigatorPopHandler({required this.child, required this.onPop, super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onPop();
        return false;
      },
      child: child,
    );
  }
}
