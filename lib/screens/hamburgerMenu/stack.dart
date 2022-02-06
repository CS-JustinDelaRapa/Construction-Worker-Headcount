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

class StackWidget extends StatefulWidget {
  const StackWidget({ Key? key }) : super(key: key);

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

  void closeDrawer(){
    return setState(() {
      xoffset = 0;
      yoffset = 0;
      scaleFactor = 1;
      isDrawerOpen =false;
    });
  }

 void openDrawer(){
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
        children: [
          buildDrawer(),
          buildPage()
        ],
      ),
    );
  }

  Widget buildDrawer() => SafeArea(
    child: HiddenDrawer(
    onSelectedItem:(item) {
      switch (item) {
        case DrawerItems.home:
          closeDrawer();
          confirmDialogue();
          return;
        default:
        setState(() => this.item = item);
        closeDrawer();
      }
    } ,
  ));

  Widget buildPage(){
    return WillPopScope(
      onWillPop: () async{
        if(isDrawerOpen){
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
          if(!isDragging) return;
          const delta = 1;
          if(details.delta.dx > delta){
            openDrawer();
          }else if(details.delta.dx < -delta){
            closeDrawer();
          }
    
          isDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(xoffset, yoffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isDrawerOpen? 20:0),
        boxShadow: isDrawerOpen?[
      const BoxShadow(
        color: Color.fromARGB(255, 194, 194, 194),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(-8, 10), // changes position of shadow
      ),
    ]: null,
      ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isDrawerOpen? 20:0),
                child: Container(
                  color: isDrawerOpen?
                  !ThemeProvider().currentTheme?
                  const Color.fromARGB(255, 218, 218, 218):const Color.fromARGB(255, 43, 43, 43)
                  : Theme.of(context).scaffoldBackgroundColor,
                  child: getDrawerPage()
                  ),
              ),
            ))),
      ),
    );
  }

  Widget getDrawerPage(){
    switch(item){
      case DrawerItems.architectural:
        return Architectural(openDrawer: openDrawer,);
      case DrawerItems.electricalAndPlumming:
        return ElectricalAndPlumbing(openDrawer: openDrawer,);
      case DrawerItems.rateOfWorkers:
        return RateOfWorkers(openDrawer: openDrawer,);                
      case DrawerItems.productivityRate:
        return ProductivityRate(openDrawer: openDrawer,);
      case DrawerItems.manPowerDistribution:
        return ManpowerDistribution(openDrawer: openDrawer,);
      case DrawerItems.additionalManpower:
        return AdditionalManpower(openDrawer: openDrawer,);
      case DrawerItems.home:
        return const HomePage();
      case DrawerItems.structural:
      default:
      return Structural(openDrawer: openDrawer,);
    }
  }

confirmDialogue(){
  return  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            content: const Text(
                "All unsave data will be deleted, Continue?"),
            actions: [
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text("Confirm"),
                onPressed: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomePage()),);
                },
              )
            ],
          ));
}

}