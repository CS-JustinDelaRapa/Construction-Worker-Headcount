// ignore_for_file: unused_import

import 'dart:async';
import 'package:engineering/screens/homePage.dart';
import 'package:engineering/screens/mainProject/additionalManpower/additionalManpower.dart';
import 'package:engineering/screens/mainProject/architectural/architectural.dart';
import 'package:engineering/screens/mainProject/electricalAndPlumbing/electricalAndPlumbing.dart';
import 'package:engineering/screens/mainProject/manpowerDistribution/manpowerDistribution.dart';
import 'package:engineering/screens/mainProject/productivityRate/productivityRate.dart';
import 'package:engineering/screens/mainProject/rateOfWorkers/rateOfWorkers.dart';
import 'package:engineering/screens/mainProject/structural/structural.dart';
import 'package:engineering/theme/themeProvider.dart';
import 'package:flutter/material.dart';
import '../../model/itemModel.dart';
import 'drawerItems.dart';
import 'hiddenDrawer.dart';
import 'package:engineering/model/ProjectModel.dart';

class StackWidget extends StatefulWidget {
  final ProjectItem project;

  const StackWidget({Key? key, required this.project}) : super(key: key);

  @override
  _StackWidgetState createState() => _StackWidgetState();
}

class _StackWidgetState extends State<StackWidget> {
  late double xoffset;
  late double yoffset;
  late double scaleFactor;

  //current selected item on hidden menu
  DrawerItem item = DrawerItems.structural;

  bool isDrawerOpen = false;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  void closeDrawer() {
    return setState(() {
      xoffset = 0;
      yoffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  void openDrawer() {
    return setState(() {
      xoffset = 280;
      yoffset = 150;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [buildDrawer(), buildPage()],
      ),
    );
  }

  Widget buildDrawer() => SafeArea(child: HiddenDrawer(
        onSelectedItem: (item) {
          switch (item) {
            case DrawerItems.home:
              closeDrawer();
              confirmDialogue();
              return;
            default:
              setState(() => this.item = item);
              closeDrawer();
          }
        },
      ));

  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }

          isDragging = false;
        },
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(xoffset, yoffset, 0)
              ..scale(scaleFactor),
            child: AbsorbPointer(
                absorbing: isDrawerOpen,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
                    boxShadow: isDrawerOpen
                        ? [
                            BoxShadow(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color.fromARGB(255, 194, 194, 194)
                                  : const Color.fromARGB(255, 26, 26, 26),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  -8, 10), // changes position of shadow
                            ),
                          ]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
                    child: Container(
                        color: isDrawerOpen
                            ? Theme.of(context).brightness == Brightness.light
                                ? const Color.fromARGB(255, 241, 241, 241)
                                : const Color.fromARGB(255, 41, 37, 58)
                            : Theme.of(context).scaffoldBackgroundColor,
                        child: getDrawerPage()),
                  ),
                ))),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.architectural:
        return Architectural(
          project: widget.project,
          openDrawer: openDrawer,
        );
      case DrawerItems.electricalAndPlumming:
        return ElectricalAndPlumbing(
          project: widget.project,
          openDrawer: openDrawer,
        );
      case DrawerItems.rateOfWorkers:
        return RateOfWorkers(
            openDrawer: openDrawer, projectFk: widget.project.id!);
      case DrawerItems.productivityRate:
        return ProductivityRate(
          project: widget.project,
          openDrawer: openDrawer,
        );
      case DrawerItems.manPowerDistribution:
        return ManpowerDistribution(
          openDrawer: openDrawer,
          project: widget.project,
        );
      case DrawerItems.additionalManpower:
        return AdditionalManpower(
          openDrawer: openDrawer,
        );
      case DrawerItems.home:
        return const HomePage();
      case DrawerItems.structural:
      default:
        return Structural(
          project: widget.project,
          openDrawer: openDrawer,
        );
    }
  }

  confirmDialogue() {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                title: const Text('Return to Home'),
                content: const Text('All unsaved data will be lost, continue?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Continue'))
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 150),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }).then((value) {
      if (value == true) {
        Timer(const Duration(milliseconds: 200), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);
        });
      }
    });
  }
}
