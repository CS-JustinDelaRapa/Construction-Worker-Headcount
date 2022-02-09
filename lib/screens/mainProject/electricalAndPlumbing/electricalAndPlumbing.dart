// ignore_for_file: file_names

import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/electricalAndPlumbing/electricalAndPlumbingItem.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class ElectricalAndPlumbing extends StatefulWidget {
  final VoidCallback openDrawer;

  const ElectricalAndPlumbing({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  _ElectricalAndPlumbingState createState() => _ElectricalAndPlumbingState();
}

class _ElectricalAndPlumbingState extends State<ElectricalAndPlumbing> {
  late double screenPercent;
  late double radius;
  bool isVerticalDragging = false;
  bool isExpanded = false;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    minimizeDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleSpacing: 0.1,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: OpenDrawerWidget(
            onClicked: widget.openDrawer,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '''Dela Cruz' long long long Apartment''',
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.caption!.color,
                    fontSize: 18),
              ),
              Text(
                '''Bungalow''',
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.caption!.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [buildBackground(), buildList()],
        ));
  }

  Widget buildBackground() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 42, 44, 46),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35), BlendMode.dstATop),
              image: const AssetImage(
                'assets/images/electricalAndPlumbing_bg.jpg',
              ),
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: const Center(
                child: Text(
              'Electrical and\nPlumbing Works',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w500),
            ))),
      ],
    );
  }

  Widget buildList() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onVerticalDragStart: (details) => isVerticalDragging = true,
        onVerticalDragUpdate: (details) {
          if (!isVerticalDragging) return;
          const delta = 1;
          if (details.delta.dy < delta) {
            expandDrawer();
          } else if (details.delta.dy > -delta) {
            minimizeDrawer();
          }

          isVerticalDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: MediaQuery.of(context).size.height * screenPercent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * screenPercent,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      child: isExpanded
                          ? AnimatedOpacity(
                              opacity: opacity,
                              duration: const Duration(milliseconds: 250),
                              child: CustomWidgets()
                                  .text_title('Electrical and Plumbing', 20))
                          : null,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ElectricalAndPlumbingItems.all
                          .map((item) => Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      print(item.title + ' was clicked');
                                    },
                                    leading: Icon(item.icon),
                                    title: Text(item.title),
                                  ),
                                  Divider(
                                    color: Theme.of(context).iconTheme.color,
                                    thickness: 0.5,
                                  )
                                ],
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  void expandDrawer() {
    return setState(() {
      screenPercent = 1;
      radius = 0;
      isExpanded = true;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          opacity = 1;
        });
      });
    });
  }

  void minimizeDrawer() {
    return setState(() {
      screenPercent = 0.5;
      radius = 20;
      isExpanded = false;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          opacity = 0;
        });
      });
    });
  }
}
