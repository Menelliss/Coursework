import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design/colors.dart';
import 'settings_page.dart';
import 'login_page.dart';
import '../function/avatar_selection_page.dart';
import '../provider/user_provider.dart';
import 'user_card_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _avatarPath;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _avatarPath = 'assets/avatars/ava${userProvider.avatar!+1}.png';
  }

  void _showChangeAvatarDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Хотите поменять фотографию?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Нет',
                style: TextStyle(
                  fontSize: 20,
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvatarSelectionPage(
                      onAvatarSelected: (String newAvatarPath) {
                        setState(() {
                          _avatarPath = newAvatarPath;
                        });
                      },
                    ),
                  ),
                );
              },
              child: const Text(
                'Да',
                style: TextStyle(
                  fontSize: 20,
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Мой профиль",
                  style: TextStyle(
                    fontSize: 36,
                    color: blackColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: _showChangeAvatarDialog,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: blackColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(_avatarPath),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userProvider.userName ?? 'Имя пользователя',
                  style: const TextStyle(
                    fontSize: 30,
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildButton(
                        context,
                        icon: Icons.settings,
                        label: 'Настройки',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SettingsPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildButton(
                        context,
                        icon: Icons.list,
                        label: 'Мои находки',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyFindingsPage()),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildButton(
                        context,
                        icon: Icons.logout,
                        label: 'Выйти из аккаунта',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onPressed,
      }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonWidth = constraints.maxWidth < 400 ? constraints.maxWidth : 400;

        return SizedBox(
          width: buttonWidth,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: accentColor,
              size: 35,
            ),
            label: Text(
              label,
              style: const TextStyle(
                color: blackColor,
                fontSize: 24,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.9),
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
        );
      },
    );
  }
}