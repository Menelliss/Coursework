import 'package:flutter/material.dart';
import '../colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 0),

            child: Column(
              children: [
                Text(
                  "Главная",
                  style: TextStyle(
                    fontSize: 38,
                    color: blackColor,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

              ],
            ),
          ),
        ],
      ),
    );
  }
}