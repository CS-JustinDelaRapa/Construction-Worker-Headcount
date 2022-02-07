import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Electrical And Plumbing'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Electrical And Plumbing', 35),
          ],
        ),
      ),
    );
  }
}
