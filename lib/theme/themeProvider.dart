// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool currentTheme = false;

  ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        brightness: Brightness.light,
        backgroundColor: const Color.fromARGB(255, 250, 252, 243),
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 255, 251),
        appBarTheme:
            const AppBarTheme(
            iconTheme: IconThemeData(color:  Color.fromARGB(255, 89, 180, 148),),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            foregroundColor: Color.fromARGB(255, 89, 180, 148)),
        primaryTextTheme:
            const TextTheme(caption: TextStyle(color:Color.fromARGB(255, 42, 38, 61))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(37,53,112, 1), // Button color
          onPrimary: const Color.fromARGB(255, 249, 247, 255), // Text color
        )),            
        iconTheme: const IconThemeData(color:Color.fromARGB(255, 91, 170, 142)),
        
        listTileTheme: const ListTileThemeData(
          selectedTileColor: Color.fromARGB(255, 137, 202, 180)
          )
        );
        
  }

  ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
        brightness: Brightness.dark,
        backgroundColor:const Color.fromARGB(255, 41, 37, 58),
        scaffoldBackgroundColor: const Color.fromARGB(255, 41, 37, 58),
        appBarTheme:
            const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white), 
            backgroundColor:Color.fromARGB(255, 35, 28, 59)),
        primaryTextTheme:
            const TextTheme(caption: TextStyle(color: Colors.white)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(139, 216, 189, 1), // Button color
          onPrimary: const Color.fromARGB(255, 32, 28, 48), // Text color
        )),
        iconTheme: const IconThemeData(color: Colors.white),
        
        listTileTheme: const ListTileThemeData(
          selectedTileColor: Color.fromARGB(232, 149, 209, 188),
        )
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
