import 'package:flutter/material.dart';
import '../api/api.dart';

class UserProvider with ChangeNotifier {
  int? userID;
  String? number;
  String? userName;
  int? avatar;
  String? userEmail;

  final db = ApiServer('http://89.169.39.16:5000');

  Future<void> login(String email, String password) async {
    try {
      int isValidUser  = await db.checkUserLogin(email, password);
      if (isValidUser  == 0) {
        final userInfo = await db.getUserInfoByEmail(email);

        if (userInfo != null) {
          userID = userInfo['id'];
          number = userInfo['number'];
          userName = userInfo['username'];
          avatar = userInfo['avatar'];
          userEmail = email;
          notifyListeners();
        } else {
          throw Exception('Пользователь не найден');
        }
      } else {
        throw Exception('Ошибка ввода почты или пароля');
      }
    } catch (e) {
      throw Exception('Ошибка при входе: $e');
    }
  }

  Future<void> signup(String email, String password, String userName, String phone) async {
    try {
      await db.register(email, password, userName, phone);

    } catch (e) {
      print('Error: $e');
      throw Exception('Ошибка при регистрации: $e');
    }
  }
}