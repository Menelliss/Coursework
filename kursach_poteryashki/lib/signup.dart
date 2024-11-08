import 'package:flutter/material.dart';
import 'package:kursach_poteryashki/colors.dart';
import 'dart:core';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordMatch = true;
  bool _isPasswordEmpty = false;
  bool _isConfirmPasswordEmpty = false;
  bool _isLoginEmpty = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: accentColor),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(top: 60)),
                  Image.asset(
                    'assets/img/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  const Text("Регистрация",
                      style: TextStyle(
                          fontSize: 35,
                          color: blackColor,
                          fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  buildLoginTextField('Имя пользователя'),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildEmailTextField('Почта'),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildTextField('Пароль, не менее 6 символов', obscureText: true, controller: _passwordController),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildTextField('Повторный пароль', obscureText: true, controller: _confirmPasswordController),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  MaterialButton(
                    minWidth: 300,
                    height: 65,
                    onPressed: () {
                      setState(() {
                        _isEmailValid = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                        ).hasMatch(_emailController.text);
                        _isPasswordMatch = _passwordController.text == _confirmPasswordController.text;
                        _isLoginEmpty = _loginController.text.isEmpty;
                        _isPasswordEmpty = _passwordController.text.isEmpty;
                        _isConfirmPasswordEmpty = _confirmPasswordController.text.isEmpty;
                      });

                      if (_isEmailValid && _isPasswordMatch && !_isLoginEmpty && !_isPasswordEmpty && !_isConfirmPasswordEmpty) {
                        Navigator.pop(context);}
                    },
                    color: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Зарегистрироваться",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Уже есть аккаунт? ",
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Войти",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _isLoginEmpty ? Colors.red : greyColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: _loginController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: _isEmailValid ? greyColor : Colors.red,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _isEmailValid = RegExp(
                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
              ).hasMatch(value);
            });
          },
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, {bool obscureText = false, required TextEditingController controller}) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (_isPasswordMatch && !_isPasswordEmpty && !_isConfirmPasswordEmpty) ? greyColor : Colors.red,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          obscureText: obscureText,
          controller: controller,
          onChanged: (value) {
            if (controller == _passwordController || controller == _confirmPasswordController) {
              setState(() {
                _isPasswordMatch = _passwordController.text == _confirmPasswordController.text;
                _isPasswordEmpty = _passwordController.text.isEmpty;
                _isConfirmPasswordEmpty = _confirmPasswordController.text.isEmpty;
              });
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
