import 'package:flutter/material.dart';
import '../design/colors.dart';
import '../api/api.dart';
import '../pages/login_page.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isEmailChecked = false;
  bool _emailExists = false;
  final recoverPas = ApiServer('http://192.168.0.6:5000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Восстановление пароля",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 14)),
              const Text(
                "Введите ваш email для восстановления пароля:",
                style: TextStyle(
                  fontSize: 20,
                  color: blackColor,
                  fontWeight: FontWeight.w400,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
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
                onPressed: () async {
                  if (!_isEmailChecked) {
                    try {
                      _emailExists = await recoverPas.checkEmail(_emailController.text);
                      if (_emailExists) {
                        setState(() {
                          _isEmailChecked = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Email не найден")),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Ошибка: $e")),
                      );
                    }
                  } else {
                    String newPassword = _newPasswordController.text;
                    if (newPassword.isNotEmpty) {
                      try {
                        await recoverPas.recoverPassword(_emailController.text, newPassword);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Пароль успешно изменен")),
                        );
                        // Переход на страницу входа
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Ошибка: $e")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Введите новый пароль")),
                      );
                    }
                  }
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
              const Padding(padding: EdgeInsets.only(top: 40)),
              if (_isEmailChecked) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Введите новый пароль:",
                    style: TextStyle(
                      fontSize: 20,
                      color: blackColor,
                      fontWeight: FontWeight.w400,
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
                    child: TextField(
                      controller: _newPasswordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Введите новый пароль',
                        hintStyle: TextStyle(
                          color: greyColor,
                          fontSize: 18,
                        ),
                      ),
                      obscureText: true, // Скрываем ввод пароля
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 30)),
                MaterialButton(
                  minWidth: 200,
                  height: 65,
                  onPressed: () async {
                    String newPassword = _newPasswordController.text;
                    if (newPassword.isNotEmpty) {
                      try {
                        await recoverPas.recoverPassword(_emailController.text, newPassword);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Пароль успешно изменен")),
                        );
                        // Переход на страницу входа
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Ошибка: $e")),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Введите новый пароль")),
                      );
                    }
                  },
                  color: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Изменить пароль",
                    style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}