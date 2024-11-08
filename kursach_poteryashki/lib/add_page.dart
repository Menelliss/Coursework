import 'package:flutter/material.dart';
import '../colors.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

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
                  "Создание объявления",
                  style: TextStyle(
                      fontSize: 38,
                      color: blackColor,
                      fontWeight: FontWeight.w900,
                      height: 1.1
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