import 'package:engineering/screens/homePage.dart';
import 'package:flutter/material.dart';

bool _light = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

ThemeData _darkTheme = ThemeData(
  accentColor: Colors.red,
  brightness: Brightness.dark,
  primaryColor: Colors.amber,
);

ThemeData _lightTheme = ThemeData(
    accentColor: Colors.pink,
    brightness: Brightness.light,
    primaryColor: Colors.blue);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Const',
      home: const HomePage(),
    );
  }
}
