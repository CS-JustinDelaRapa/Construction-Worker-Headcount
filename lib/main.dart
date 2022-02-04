import 'package:engineering/screens/homePage.dart';
import 'package:engineering/theme/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider()..initialize(),
    child: const MyApp()
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,provider,child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: provider.themeMode,
          debugShowCheckedModeBanner: false,
          title: 'Const',
          home: const HomePage(),
        );
      }
    );
  }
}
