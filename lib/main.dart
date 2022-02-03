import 'package:engineering/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _light = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeValue = (prefs.getBool('theme') ?? true);
  runApp(MyApp(themeValue: themeValue));
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

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool themeValue;
  MyApp({Key? key, required this.themeValue}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _light ? _lightTheme : _darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Const',
      home: HomePage(themeValue: themeValue,),
    );
  }
}
