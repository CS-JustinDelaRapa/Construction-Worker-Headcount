import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class Structural extends StatefulWidget {
final VoidCallback openDrawer;

 const  Structural({ Key? key, required this.openDrawer }) : super(key: key);

  @override
  _StructuralState createState() => _StructuralState();
}

class _StructuralState extends State<Structural> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(onClicked: widget.openDrawer,),
        title: const Text('Structural'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Structural', 35, 10),
          ],
        ),
      ),
    );
  }
}