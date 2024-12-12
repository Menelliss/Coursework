import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design/colors.dart';
import '../pages/database.dart';
import '../pages/user_provider.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _changeEmail() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String? oldEmail = userProvider.userEmail;
    String newEmail = _emailController.text;

    if (newEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите новый email")),
      );
      return;
    }

    final db = Database(userProvider.createConnection());
    await db.open();

    int result = await db.changeEmail(oldEmail!, newEmail);

    await db.close();

    if (result == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email успешно изменен")),
      );
      userProvider.userEmail = newEmail;
      userProvider.notifyListeners();
      _emailController.clear();
    } else if (result == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Этот email уже занят")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Сменить почту"),
        backgroundColor: accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Новый email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeEmail,
              child: const Text("Сменить почту"),
            ),
          ],
        ),
      ),
    );
  }
}