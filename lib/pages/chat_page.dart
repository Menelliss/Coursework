import 'package:flutter/material.dart';
import 'package:kursach_poteryashki/design/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> chats = [
    {'id': '1', 'name': 'Иван Иванов', 'icon': Icons.person},
    {'id': '2', 'name': 'Мария Петрова', 'icon': Icons.person},
    {'id': '3', 'name': 'Александр Смирнов', 'icon': Icons.person},
    {'id': '4', 'name': 'Артур Николаев', 'icon': Icons.person},
    {'id': '5', 'name': 'Андрей Маслов', 'icon': Icons.person},
    {'id': '6', 'name': 'Влад Ковалев', 'icon': Icons.person},
    {'id': '7', 'name': 'Артем Егоров', 'icon': Icons.person},
  ];

  List<Map<String, dynamic>> filteredChats = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredChats = chats;
  }

  void _filterChats(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredChats = chats;
      } else {
        filteredChats = chats.where((chat) {
          return chat['name']!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _search() {
    _filterChats(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Скоро будут доступны...",
                  style: TextStyle(
                    fontSize: 20,
                    color: blackColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  "Чаты",
                  style: TextStyle(
                    fontSize: 38,
                    color: greyColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(
                      color: greyColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Найти чат...',
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          color: greyColor,
                          fontSize: 18,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search_sharp,
                            color: accentColor,
                          ),
                          onPressed: _search,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      var chat = filteredChats[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: greyColor.withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(chat['icon']),
                          ),
                          title: Text(
                            chat['name']?.isNotEmpty == true
                                ? chat['name']!
                                : 'Неизвестный',
                            style: const TextStyle(
                              fontSize: 20,
                              color: greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            //
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
