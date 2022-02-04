import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool currentTheme = false;

  ThemeMode get themeMode{
    if (!currentTheme) {
      return ThemeMode.light;
    }   else {
      return ThemeMode.dark;
    }
  }  
  initialize()async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    currentTheme = _prefs.getBool('themeVal') ?? false;
    notifyListeners();
  }

  changeTheme(bool fromWidget)async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('themeVal', fromWidget);
    currentTheme = fromWidget;
    notifyListeners();
  }
}