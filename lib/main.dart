import 'package:flutter/material.dart';
import 'package:login_wifi/home.dart';
import 'package:login_wifi/login.dart';
import 'package:login_wifi/pinfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '登陆校园网',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyMainPage(),
    );
  }
}

class MyMainPage extends StatelessWidget {
  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getInfo(), builder: (context, snapshot) => snapshot.data == null ? const PInfo() : MyHomePage(accPwd: snapshot.data!));
  }
}
