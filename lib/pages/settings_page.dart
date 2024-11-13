import 'package:flutter/material.dart';
import '../design/colors.dart';
import 'login_page.dart';
import '../function/new_password.dart';
import '../function/change_email_page.dart';
import '../function/change_password_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: null),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 00, 10, 0),
              child: Column(
                children: [
                  const Text(
                    "Настройки",
                    style: TextStyle(
                      fontSize: 38,
                      color: blackColor,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // const SizedBox(height: 30),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const ChangeEmailPage(),
                      //       ),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: whiteColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     fixedSize: const Size(180, 180),
                      //     elevation: 6,
                      //     shadowColor: Colors.black.withOpacity(0.3),
                      //   ),
                      //   child: const Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         Icons.mail_rounded,
                      //         color: accentColor,
                      //         size: 60,
                      //       ),
                      //       SizedBox(height: 10),
                      //       Text(
                      //         'Сменить почту',
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(
                      //           color: blackColor,
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const ChangePasswordPage(),
                      //       ),
                      //     );
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: whiteColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //     fixedSize: const Size(180, 180),
                      //     elevation: 6,
                      //     shadowColor: Colors.black.withOpacity(0.3),
                      //   ),
                      //   child: const Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Icon(
                      //         Icons.lock_rounded,
                      //         color: accentColor,
                      //         size: 60,
                      //       ),
                      //       SizedBox(height: 10),
                      //       Text(
                      //         'Поменять пароль',
                      //         textAlign: TextAlign.center,
                      //         style: TextStyle(
                      //           color: blackColor,
                      //           fontSize: 22,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => const NewPasswordPage(),
                  //         ),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: whiteColor,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       minimumSize: const Size(double.infinity, 80),
                  //       elevation: 6,
                  //       shadowColor: blackColor.withOpacity(0.3),
                  //     ),
                  //     child: const Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         SizedBox(height: 10),
                  //         Text(
                  //           'Восстановить пароль',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: blackColor,
                  //             fontSize: 22,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                              (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 80),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Выйти из аккаунта',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: redColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
