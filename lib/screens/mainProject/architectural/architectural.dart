import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class Architectural extends StatefulWidget {
  final VoidCallback openDrawer;

  const Architectural({Key? key, required this.openDrawer}) : super(key: key);

  @override
  _ArchitecturalState createState() => _ArchitecturalState();
}

class _ArchitecturalState extends State<Architectural> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(
          onClicked: widget.openDrawer,
        ),
        title: const Text('Architectural'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Architectural', 35),
          ],
        ),
      ),
    );
  }
}
