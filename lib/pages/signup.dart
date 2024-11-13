import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:kursach_poteryashki/design/colors.dart';
import 'database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isEmailValid = true;
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
                  const Text(
                    "Регистрация",
                    style: TextStyle(
                      fontSize: 35,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  buildLoginTextField('Имя пользователя'),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildEmailTextField('Почта'),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildPhoneTextField('Номер телефона'),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildTextField('Пароль, не менее 6 символов', obscureText: true, controller: _passwordController),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  buildTextField('Повторный пароль', obscureText: true, controller: _confirmPasswordController),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),

                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isEmailValid = RegExp(
                          r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$",
                        ).hasMatch(_emailController.text);
                        _isPasswordMatch = _passwordController.text == _confirmPasswordController.text;
                        _isLoginEmpty = _loginController.text.isEmpty;
                        _isPasswordEmpty = _passwordController.text.isEmpty;
                        _isConfirmPasswordEmpty = _confirmPasswordController.text.isEmpty;
                      });

                      if (_isEmailValid &&
                          _isPasswordMatch &&
                          !_isLoginEmpty &&
                          !_isPasswordEmpty &&
                          !_isConfirmPasswordEmpty) {
                        final conn = PostgreSQLConnection(
                          '10.0.2.2',
                          5432,
                          'Poteryaski',
                          username: 'postgres',
                          password: 'rootroot',
                        );
                        final db = Database(conn);

                        try {
                          await db.open();
                          await db.registration(
                            _emailController.text,
                            _passwordController.text,
                            _loginController.text,
                            _phoneController.text,
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          // Обработка ошибки
                          print('Ошибка при регистрации: $e');
                        } finally {
                          await db.close();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        minimumSize: const Size(300, 65)
                    ),
                    child: const Text(
                      "Зарегистрироваться",
                      style: TextStyle(
                        color: whiteColor,
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
        color: whiteColor,
        border: Border.all(
          color: _isLoginEmpty ? redColor : greyColor,
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
        color: whiteColor,
        border: Border.all(
          color: _isEmailValid ? greyColor : redColor,
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
                r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$",
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
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (_isPasswordMatch && !_isPasswordEmpty && !_isConfirmPasswordEmpty) ? greyColor : redColor,
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

  Widget buildPhoneTextField(String hintText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: (_phoneController.text.length == 10) ? greyColor : redColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 12,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 18,
            ),
            counterText: '',
          ),
          onChanged: (value) {
            setState(() {
              if (!_phoneController.text.startsWith('+7')) {
                _phoneController.text = '+7${_phoneController.text}';
                _phoneController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _phoneController.text.length),
                );
              }
            });
          },
        ),
      ),
    );
  }
}

