import 'package:flutter/material.dart';
import '../colors.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Column(
              children: [
                const Text(
                  "Мой профиль",
                  style: TextStyle(
                    fontSize: 38,
                    color: blackColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: blackColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/avatar.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Николаева Елизавета Олеговна",
                  style: TextStyle(
                    fontSize: 30,
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _buildButton(
                      context,
                      icon: Icons.search,
                      label: 'Потерянные вещи',
                      onPressed: () {
                        print('Нажата кнопка для перехода к потерянным вещам');
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildButton(
                      context,
                      icon: Icons.playlist_add_check_outlined,
                      label: 'Найденные вещи',
                      onPressed: () {
                        print('Нажата кнопка для перехода к найденным вещам');
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildButton(
                      context,
                      icon: Icons.settings,
                      label: 'Настройки',
                      onPressed: () {
                        print('Нажата кнопка открытия настроек');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onPressed,
      }) {
    return SizedBox(
      width: double.infinity,
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
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}