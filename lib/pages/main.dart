import 'package:flutter/material.dart';
import 'login_page.dart';
import '../function/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
