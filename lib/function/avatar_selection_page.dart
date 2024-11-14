import 'package:flutter/material.dart';
import 'package:kursach_poteryashki/design/colors.dart';
import '../pages/database.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';
import '../pages/user_provider.dart';

class AvatarSelectionPage extends StatelessWidget {
  final void Function(String) onAvatarSelected;

  const AvatarSelectionPage({Key? key, required this.onAvatarSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final List<String> avatarPaths = [
      'assets/avatars/ava1.png',
      'assets/avatars/ava2.png',
      'assets/avatars/ava3.png',
      'assets/avatars/ava4.png',
      'assets/avatars/ava5.png',
      'assets/avatars/ava6.png',
      'assets/avatars/ava7.png',
      'assets/avatars/ava8.png',
      'assets/avatars/ava9.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите аватар'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: avatarPaths.length,
        itemBuilder: (context, index) {
          final path = avatarPaths[index];

          return GestureDetector(
            onTap: () async {
              await _updateAvatar(userProvider.userEmail!, index);
              userProvider.avatar = index;
              onAvatarSelected(path);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(path),
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: greyColor),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _updateAvatar(String userEmail, int avatarIndex) async {
    final conn = PostgreSQLConnection(
      '10.0.2.2',
      5432,
      'Poteryaski',
      username: 'postgres',
      password: 'rootroot',
    );

    final db = Database(conn);

    await db.open();
    await db.changeAvatar(userEmail, avatarIndex); // Передаем userEmail
    await db.close();
  }
}