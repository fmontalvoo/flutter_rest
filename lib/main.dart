import 'package:flutter/material.dart';
import 'package:flutter_rest/auth/auth.dart';
import 'package:flutter_rest/view/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cliente REST',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(
        auth: Auth(),
      ),
    );
  }
}
