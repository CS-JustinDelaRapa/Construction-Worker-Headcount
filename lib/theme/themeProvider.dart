import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool currentTheme = false;

  ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      brightness: Brightness.light,
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      primaryColor: Colors.red,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: Colors.amber[800], // Button color
        onPrimary: Colors.black, // Text color
      )),
      appBarTheme: AppBarTheme(backgroundColor: Colors.amber[800]),
      //  popupMenuTheme: PopupMenuThemeData(color: Colors.amber[800]),
      //  iconTheme: IconThemeData(color: Colors.amber[800]),
      cardColor: Colors.grey[800], //card widget color
      // backgroundColor: Colors.grey[800], //di ko pa alam
      primaryColor: Colors.pink, //di ko pa alam
      scaffoldBackgroundColor: Colors.grey[900], //color ng scaffold
    );
  }

  ThemeData get themeMode {
    if (!currentTheme) {
      return buildLightTheme();
    } else {
      return buildDarkTheme();
    }
  }

  initialize() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    currentTheme = _prefs.getBool('themeVal') ?? false;
    notifyListeners();
  }

  changeTheme(bool fromWidget) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('themeVal', fromWidget);
    currentTheme = fromWidget;
    notifyListeners();
  }
}
