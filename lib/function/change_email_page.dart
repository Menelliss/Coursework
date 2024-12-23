import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design/colors.dart';
import '../provider/user_provider.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final TextEditingController _newEmailController = TextEditingController();

  Future<void> _changeEmail() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String? oldEmail = userProvider.userEmail;
    String newEmail = _newEmailController.text;

    if (newEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите новый email")),
      );
      return;
    }

    try {
      String result = await userProvider.db.changeEmail(oldEmail!, newEmail);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );

      if (result == 'Email успешно изменен') {
        userProvider.userEmail = newEmail;
        userProvider.notifyListeners();
        _newEmailController.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка при смене email: $e")),
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
              controller: _newEmailController,
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