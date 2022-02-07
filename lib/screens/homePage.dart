// ignore: file_names
import 'package:engineering/screens/selectProject/create.dart';
import 'package:engineering/screens/selectProject/load.dart';
import 'package:engineering/theme/themeProvider.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hamburgerMenu/stack.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Consumer<ThemeProvider>(builder: (context, provider, child) {
          return PopupMenuButton<String>(
            icon: const Icon(Icons.menu_outlined),
            itemBuilder: (context) => [
              PopupMenuItem(
                padding: const EdgeInsets.only(right: 0),
                child: Consumer<ThemeProvider>(
                    builder: (context, provider, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Transform.scale(
                          scale: 1,
                          child: Switch.adaptive(
                              thumbColor:
                                  MaterialStateProperty.all(Colors.black),
                              trackColor:
                                  MaterialStateProperty.all(Colors.grey[500]),
                              activeThumbImage:
                                  const AssetImage('assets/images/daymode.png'),
                              inactiveThumbImage: const AssetImage(
                                  'assets/images/darkmode.png'),
                              value: provider.currentTheme,
                              onChanged: (value) {
                                setState(() {
                                  provider.changeTheme(value);
                                });
                              }),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child:
                              CustomWidgets().text_subtitle('Theme Mode', 16)),
                    ],
                  );
                }),
              ),
              PopupMenuItem(
                value: 'light',
                child: StatefulBuilder(builder: (context, stateSetter) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                        child: Icon(
                          Icons.info,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const Text("About")
                    ],
                  );
                }),
              ),
            ],
          );
        }),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(flex: 4, child: Image.asset('assets/images/sample.PNG')),
            Flexible(
              flex: 1,
              child: CustomWidgets().text_title('Construction Count', 30),
            ),
            Flexible(
              flex: 1,
              child: CustomWidgets().text_subtitle(
                  'Construction Worker Headcount Application', 15),
            ),
            CustomWidgets().nav_Button('Create Project', const Icon(Icons.add),
                context, null, () => const CreateProject()),
            CustomWidgets().nav_Button(
                'Load Project',
                const Icon(Icons.folder_open),
                context,
                null,
                () => const LoadProject()),
            const Flexible(
                flex: 2,
                child: SizedBox(
                  height: 50,
                )),
          ],
        ),
      ),
    );
  }
}
