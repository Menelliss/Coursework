import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../design/colors.dart';
import '../provider/user_provider.dart';
import 'things_card_lost.dart';
import 'things_card_find.dart';

class MyFindingsPage extends StatefulWidget {
  const MyFindingsPage({Key? key}) : super(key: key);

  @override
  _MyFindingsPageState createState() => _MyFindingsPageState();
}

class _MyFindingsPageState extends State<MyFindingsPage> {
  List<dynamic> items = [];
  bool _isLostSelected = true;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (_isLostSelected) {
      items = await userProvider.db.getUserLostThings(userProvider.userID!);
    } else {
      items = await userProvider.db.getUserFindThings(userProvider.userID!);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Мои вещи"),
        backgroundColor: accentColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
            children: <Widget>[
              ToggleButtons(
                isSelected: [_isLostSelected, !_isLostSelected],
                onPressed: (int index) {
                  setState(() {
                    _isLostSelected = index == 0;
                    _fetchItems();
                  });
                },
                borderRadius: BorderRadius.circular(12),
                borderColor: greyColor,
                fillColor: accentColor,
                selectedColor: whiteColor,
                color: greyColor,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Потерянные',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Найденные',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double maxCrossAxisExtent = 200;

                    if (constraints.maxWidth > 600) {
                      maxCrossAxisExtent = 300;
                    }
                    if (constraints.maxWidth > 900) {
                      maxCrossAxisExtent = 400;
                    }

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: maxCrossAxisExtent,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var item = items[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => _isLostSelected
                                    ? ProductDetailsPageLost(thing: item)
                                    : ProductDetailsPageFind(thing: item),
                              ),
                            );
                          },
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 300,
                            ),
                            child: Card(
                              color: whiteColor,
                              elevation: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                    child: Image.asset(
                                      item['image'] ?? 'assets/img/default.png',
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/img/default.png',
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item['title'] ?? 'Без названия',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      item['address'] ?? 'Без адреса',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: greyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}