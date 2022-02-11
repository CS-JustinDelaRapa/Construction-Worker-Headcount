// ignore: file_names
import 'package:engineering/screens/selectProject/about.dart';
import 'package:engineering/screens/selectProject/create.dart';
import 'package:engineering/screens/selectProject/load.dart';
import 'package:engineering/theme/themeProvider.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
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
      extendBodyBehindAppBar: true,
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
            icon: Icon(Icons.menu_outlined, color:
            Theme.of(context).brightness == Brightness.light?
            const Color.fromARGB(255, 41, 37, 58)
            :null,),
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
                          activeToggleColor: const Color.fromARGB(255, 156, 148, 170),
                          inactiveToggleColor: const Color(0xFF2F363D),
                          activeSwitchBorder: Border.all(
                            color: const Color.fromARGB(255, 103, 96, 116),
                            width: 3.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: const Color(0xFFD1D5DA),
                            width: 3.0,
                          ),
                          activeColor: const Color.fromARGB(255, 79, 74, 87),
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
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
        height: MediaQuery.of(context).size.height,
        decoration:const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image:AssetImage(
              'assets/images/main_bg.jpg',
            ),
          ),
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        color:   Theme.of(context).brightness == Brightness.light?
                 const Color.fromARGB(255, 92, 175, 146).withOpacity(0.8):
                 const Color.fromARGB(255, 32, 28, 48).withOpacity(0.9),
      ),
              Column(
                children: [
                SizedBox(
                height: MediaQuery.of(context).size.height*0.1
                ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.2,
                        child: Image.asset('assets/images/logo_png.png')),
                      const Text('Construction App', 
                        style: TextStyle(
                          fontSize: 35, 
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      const Text('Construction Worker Headcount Application', 
                        style: TextStyle(
                          fontSize: 14, 
                          fontWeight: FontWeight.w400,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Center(
                child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomWidgets().nav_Button('Create Project', const Icon(Icons.add),
                      context, 0.8, 0.08, () => const CreateProject(), null),
                  const SizedBox(height: 30),
                  CustomWidgets().nav_Button(
                    'Load Project',
                    const Icon(Icons.folder_open),
                    context,
                    0.8,
                    0.08,
                    () => const LoadProject(),
                    null,
                  ),
                ],
                ),
              ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
