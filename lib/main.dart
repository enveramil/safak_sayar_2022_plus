import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safak_sayar_2022_plus/screens/base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Colors.black12,
            elevation: 3,
            systemOverlayStyle: SystemUiOverlayStyle.light),
      ),
      home: const MyHomePage(),
    );
  }
}
