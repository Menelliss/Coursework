import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServer {
  final String baseUrl;

  ApiServer(this.baseUrl);

  Future<int> checkUserLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/check_user_login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return 0;
    } else if (response.statusCode == 401) {
      return 1;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>?> getUserInfoByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/get_user_info?email=$email'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to get user info: ${response.body}');
    }
  }

  Future<bool> checkEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/check_email?email=$email'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Ошибка при проверке email: ${response.body}');
    }
  }

  Future<void> recoverPassword(String email, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recover_password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(<String, String>{
        'email': email,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при восстановлении пароля: ${response.body}');
    }
  }

  Future<void> register(String email, String password, String username, String number) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'username': username,
        'number': number,
      }),
    );

    if (response.statusCode == 201) {
    } else {
      throw Exception('Failed to register user: ${response.body}');
    }
  }

  Future<String> changePassword(String email, String oldPassword, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/change_password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'old_password': oldPassword,
        'new_password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return 'Пароль успешно изменен';
    } else if (response.statusCode == 404) {
      return 'Пользователь не найден';
    } else if (response.statusCode == 400) {
      return 'Неверный старый пароль';
    } else {
      return 'Ошибка: ${json.decode(response.body)['message']}';
    }
  }

  Future<String> changeEmail(String oldEmail, String newEmail) async {
    final response = await http.post(
      Uri.parse('$baseUrl/change_email'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'old_email': oldEmail,
        'new_email': newEmail,
      }),
    );

    if (response.statusCode == 200) {
      return 'Email успешно изменен';
    } else if (response.statusCode == 400) {
      return 'Новый email уже существует';
    } else if (response.statusCode == 404) {
      return 'Пользователь не найден';
    } else {
      return 'Ошибка: ${json.decode(response.body)['message']}';
    }
  }


  Future<void> changeAvatar(String email, int avatar) async {
    final response = await http.post(
      Uri.parse('$baseUrl/change_avatar'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'avatar': avatar,
      }),
    );

    if (response.statusCode == 200) {} else {
      throw Exception('Failed to change avatar: ${response.body}');
    }
  }

  Future<List<dynamic>> getAllFindThings() async {
    final response = await http.get(Uri.parse('$baseUrl/find_things'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load found things: ${response.body}');
    }
  }


  Future<List<dynamic>> searchFindThings(String keyword) async {
    final response = await http.get(Uri.parse('$baseUrl/find_things/search?word=$keyword'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search found things: ${response.body}');
    }
  }

  Future<List<dynamic>> getUserFindThings(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/find_things/user/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user found things: ${response.body}');
    }
  }


  Future<void> addFindThing(Map<String, dynamic> findThingData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_find_things'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(findThingData),
    );

    if (response.statusCode == 201) {
    } else {
      throw Exception('Failed to add find thing: ${response.body}');
    }
  }

  Future<List<dynamic>> getAllLostThings() async {
    final response = await http.get(Uri.parse('$baseUrl/lost_things'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load lost things: ${response.body}');
    }
  }

  Future<List<dynamic>> searchLostThings(String keyword) async {
    final response = await http.get(Uri.parse('$baseUrl/lost_things/search?word=$keyword'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search lost things: ${response.body}');
    }
  }

  Future<List<dynamic>> getUserLostThings(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/lost_things/user/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user lost things: ${response.body}');
    }
  }

  Future<void> addLostThing(Map<String, dynamic> lostThingData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_lost_things'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(lostThingData),
    );

    if (response.statusCode == 201) {
    } else {
      throw Exception('Failed to add lost thing: ${response.body}');
    }
  }
}



