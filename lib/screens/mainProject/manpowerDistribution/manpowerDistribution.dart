// ignore_for_file: file_names

import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class ManpowerDistribution extends StatefulWidget {
  final VoidCallback openDrawer;

  const ManpowerDistribution({Key? key, required this.openDrawer})
      : super(key: key);

  @override
  _ManpowerDistributionState createState() => _ManpowerDistributionState();
}

class _ManpowerDistributionState extends State<ManpowerDistribution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Manpower Distribution'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Manpower Distribution', 35),
          ],
        ),
      ),
    );
  }
}
