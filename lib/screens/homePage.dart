// ignore: file_names
import 'package:engineering/screens/selectProject/about.dart';
import 'package:engineering/screens/selectProject/create.dart';
import 'package:engineering/screens/selectProject/load.dart';
import 'package:engineering/theme/themeProvider.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
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
          return PopupMenuButton<int>(
            onSelected: (val) {
              if (val == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const about()));
              }
            },
            icon: const Icon(Icons.menu_outlined),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Consumer<ThemeProvider>(
                    builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: FlutterSwitch(
                          showOnOff: true,
                          inactiveText: 'Light Mode',
                          activeText: 'Dark Mode',
                          inactiveTextColor: Colors.black,
                          activeTextColor: Colors.white,
                          activeTextFontWeight: FontWeight.normal,
                          inactiveTextFontWeight: FontWeight.normal,
                          width: 125.0,
                          height: 38.5,
                          toggleSize: 27,
                          value: provider.currentTheme,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: Color.fromARGB(255, 156, 148, 170),
                          inactiveToggleColor: const Color(0xFF2F363D),
                          activeSwitchBorder: Border.all(
                            color: const Color.fromARGB(255, 103, 96, 116),
                            width: 3.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: const Color(0xFFD1D5DA),
                            width: 3.0,
                          ),
                          activeColor: Color.fromARGB(255, 79, 74, 87),
                          inactiveColor: Colors.white,
                          activeIcon: const Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFF8E3A1),
                          ),
                          inactiveIcon: const Icon(
                            Icons.wb_sunny,
                            color: Color(0xFFFFDF5D),
                          ),
                          onToggle: (val) {
                            provider.changeTheme(val);
                          },
                        ),
                      ),
                      // Flexible(
                      //   flex: 1,
                      //   child: Transform.scale(
                      //     scale: 1,
                      //     child: Switch.adaptive(
                      //         thumbColor:
                      //             MaterialStateProperty.all(Colors.black),
                      //         trackColor:
                      //             MaterialStateProperty.all(Colors.grey[500]),
                      //         activeThumbImage:
                      //             const AssetImage(
                      //             'assets/images/darkmode.png'),
                      //         inactiveThumbImage:
                      //         const AssetImage('assets/images/daymode.png'),
                      //         value: provider.currentTheme,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             provider.changeTheme(value);
                      //           });
                      //         }),
                      //   ),
                      // ),
                    ],
                  );
                }),
              ),
              PopupMenuItem(
                value: 1,
                child: StatefulBuilder(builder: (context, stateSetter) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
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
                context, 0.6, 0.05, () => const CreateProject(), null),
            CustomWidgets().nav_Button(
              'Load Project',
              const Icon(Icons.folder_open),
              context,
              0.6,
              0.05,
              () => const LoadProject(),
              null,
            ),
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
