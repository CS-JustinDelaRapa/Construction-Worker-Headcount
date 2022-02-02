import 'package:engineering/screens/homePage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Const',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const HomePage(),
    );
  }
}
