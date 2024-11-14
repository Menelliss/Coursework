import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'package:kursach_poteryashki/design/colors.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                buildLoginTextField('Имя пользователя', _loginController),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                buildEmailTextField('Почта', _emailController),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                buildPhoneTextField('Номер телефона', _phoneController),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                buildTextField('Пароль, не менее 6 символов', _passwordController, true),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                buildTextField('Повторный пароль', _confirmPasswordController, true),
                const Padding(padding: EdgeInsets.only(bottom: 30)),
                ElevatedButton(
                  onPressed: () async {
                    if (_passwordController.text == _confirmPasswordController.text) {
                      try {
                        await Provider.of<UserProvider>(context, listen: false).signup(
                          _emailController.text,
                          _passwordController.text,
                          _loginController.text,
                          _phoneController.text,
                        );
                        Navigator.pop(context); // Вернуться на страницу входа
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Пароли не совпадают')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    minimumSize: const Size(300, 65),
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
    );
  }

  Widget buildLoginTextField(String hintText, TextEditingController controller) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: controller,
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

  Widget buildEmailTextField(String hintText, TextEditingController controller) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: controller,
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

  Widget buildTextField(String hintText, TextEditingController controller, bool obscureText) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
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

  Widget buildPhoneTextField(String hintText, TextEditingController controller) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greyColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
        child: TextField(
          controller: controller,
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
        ),
      ),
    );
  }
}

