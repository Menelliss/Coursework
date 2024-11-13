import 'package:flutter/material.dart';
import 'package:kursach_poteryashki/design/colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> thing;

  ProductDetailsPage({Key? key, required this.thing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    thing['image'] ?? 'assets/img/default.png',
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/img/default.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          thing['title'] ?? 'Без названия',
                          style: const TextStyle(
                            fontSize: 28,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          thing['address'] ?? 'Без адреса',
                          style: const TextStyle(
                            fontSize: 20,
                            color: greyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          thing['description'] ?? 'Нет описания',
                          style: const TextStyle(
                            fontSize: 20,
                            color: blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Дата потери: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: thing['lost_date']?.toString().substring(0, 10) ?? 'Неизвестно',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Время потери: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${thing['time_1']?.toString().substring(0, 5) ?? 'Не указано'} - ${thing['time_2']?.toString().substring(0, 5) ?? 'Не указано'}',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                              color: blackColor,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Телефон: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: thing['number'] ?? 'Не указано',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
