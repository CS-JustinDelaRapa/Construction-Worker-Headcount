// ignore_for_file: unused_import, avoid_print

import 'dart:ffi';

import 'package:engineering/model/ProjectItem.dart';
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/screens/mainProject/structural/bungalowStructuralItem.dart';
import 'package:engineering/screens/mainProject/structural/forms/earthworkForms.dart';
import 'package:engineering/screens/mainProject/structural/twoStoreyStructuralItems.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class Structural extends StatefulWidget {
  final VoidCallback openDrawer;
  final ProjectItem project;

  const Structural({Key? key, required this.openDrawer, required this.project}) : super(key: key);

  @override
  _StructuralState createState() => _StructuralState();
}

class _StructuralState extends State<Structural> {
  late double screenPercent;
  late double radius;
  double opacity = 0;

  bool isVerticalDragging = false;
  bool isExpanded = false;
  bool isScrolled = false;

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
              widget.project.project_name,
              style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.caption!.color,
                  fontSize: 18),
            ),
            Text(
              widget.project.type,
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
      ),
      floatingActionButton: isExpanded
          ? FloatingActionButton(
              child: const Icon(Icons.arrow_downward),
              onPressed: () {
                minimizeDrawer();
              })
          : null,
    );
  }

  Widget buildBackground() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 42, 44, 46),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35), BlendMode.dstATop),
              image: const AssetImage(
                'assets/images/structural_bg.jpeg',
              ),
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: const Center(
                child: Text(
              'Structural\nWorks',
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
        onVerticalDragStart:
            isExpanded ? null : (details) => isVerticalDragging = true,
        onVerticalDragUpdate: isExpanded
            ? null
            : (details) {
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
          duration: const Duration(milliseconds: 250),
          height: MediaQuery.of(context).size.height * screenPercent,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: SingleChildScrollView(
                physics:
                    isExpanded ? null : const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: SizedBox(
                        child: isExpanded
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                child: AnimatedOpacity(
                                    opacity: opacity,
                                    duration: const Duration(milliseconds: 250),
                                    child: CustomWidgets()
                                        .text_title('STRUCTURAL WORKS', 20)),
                              )
                            : const SizedBox(height: 10),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        children: BungalowStructuralItems.all
                            .map((item) => ListTile(
                                onTap: () {
                                  print(item.title);
                                },
                                title: Row(
                                  children: [
                                    Icon(item.icon),
                                    const SizedBox(width: 15),
                                    Text(
                                      item.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AnimatedSwitcher(
                                        transitionBuilder: (Widget child,
                                                Animation<double> animation) =>
                                            ScaleTransition(
                                                scale: animation, child: child),
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: returnItem(item.title)),
                                  ],
                                )))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget expandItem(List<String> columnList) {
    Padding returnColumn;
    List<TextButton> buttonsList = [];
    for (int x = 0; x < columnList.length; x++) {
      buttonsList.add(TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EarthWorksForm(
                          workType: columnList[x],
                        )));

            print(columnList[x]);
            print(x);
          },
          style: const ButtonStyle(alignment: Alignment.centerLeft),
          child: Text(
            columnList[x],
          )));
    }
    returnColumn = Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: buttonsList),
    );
    return returnColumn;
  }

  Widget staticItem(List<String> columnList) {
    Column returnColumn;
    List<Padding> textList = [];
    for (int x = 0; x < columnList.length; x++) {
      textList.add(Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 8, top: 8),
          child: Text(columnList[x])));
    }
    returnColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: textList);
    return returnColumn;
  }

  Widget returnItem(String itemName) {
    switch (itemName) {
      case 'Formworks':
        if (!isExpanded) {
          return Container();
        }
        return expandItem(true
            ? BungalowStructuralItems.listFormWorks
            : TwoStoreyStructuralItems.listFormWorks);
      case 'Masonry Works':
        if (!isExpanded) {
          return Container();
        }
        return expandItem(true
            ? BungalowStructuralItems.listMasonryWorks
            : TwoStoreyStructuralItems.listMasonryWorks);
      case 'Steel Reinforcement Works':
        if (!isExpanded) {
          return Container();
        }
        return expandItem(true
            ? BungalowStructuralItems.listSteelReinforecedWorks
            : TwoStoreyStructuralItems.listSteelReinforecedWorks);
      case 'Reinforced Cement Works':
        if (!isExpanded) {
          return Container();
        }
        return expandItem(true
            ? BungalowStructuralItems.listReinforecedWorks
            : TwoStoreyStructuralItems.listReinforecedWorks);
      case 'Earthworks':
      default:
        if (!isExpanded) {
          return Container();
        }
        return expandItem(true
            ? BungalowStructuralItems.listEarthWorks
            : TwoStoreyStructuralItems.listEarthWorks);
    }
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
