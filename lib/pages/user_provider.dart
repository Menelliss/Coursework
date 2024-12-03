import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'database.dart';

class UserProvider with ChangeNotifier {
  int? userID;
  String? number;
  String? userName;
  int? avatar;
  String? userEmail;

  PostgreSQLConnection createConnection() {
    return PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'Poteryaski',
      username: 'postgres',
      password: 'rootroot',
    );
  }

  Future<void> login(String email, String password) async {
    final db = Database(createConnection());
    await db.open();

    int isValidUser  = await db.checkUserLogin(email, password);
    if (isValidUser  == 0) {
      userID = await db.getUserIdByEmail(email);
      number = await db.getUserNumberByEmail(email);
      userName = await db.getUserNameByEmail(email);
      avatar = await db.getUserAvatarByEmail(email);
      userEmail = email;
      notifyListeners();
    } else {
      throw Exception('Ошибка ввода почты или пароля');
    }

    await db.close();
  }

  Future<void> signup(String email, String password, String userName, String phone) async {
    final db = Database(createConnection());
    await db.open();
    await db.registration(email, password, userName, phone);
    await db.close();
  }
}