import 'package:flutter/material.dart';
import '../design/colors.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Восстановление пароля",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 14)),
            const Text(
              "Введите ваш email для восстановления пароля:",
              style: TextStyle(
                fontSize: 20,
                color: blackColor,
                fontWeight: FontWeight.w400
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              height: 60,
              constraints: const BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Введите ваш email',
                    hintStyle: TextStyle(
                      color: greyColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            MaterialButton(
              minWidth: 200,
              height: 65,
              onPressed: () {
              },
              color: accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Отправить",
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
          ],
        ),
      ),
    );
  }
}
