// ignore_for_file: file_names
import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class RateOfWorkers extends StatefulWidget {
  final VoidCallback openDrawer;

  const RateOfWorkers({Key? key, required this.openDrawer}) : super(key: key);

  @override
  _RateOfWorkersState createState() => _RateOfWorkersState();
}

class _RateOfWorkersState extends State<RateOfWorkers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Rate of Workers'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Rate of Workers', 35),
          ],
        ),
      ),
    );
  }
}
