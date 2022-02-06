import 'package:engineering/screens/hamburgerMenu/openDrawer.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';

class AdditionalManpower extends StatefulWidget {
final VoidCallback openDrawer;

 const  AdditionalManpower({ Key? key, required this.openDrawer }) : super(key: key);

  @override
  _AdditionalManpowerState createState() => _AdditionalManpowerState();
}

class _AdditionalManpowerState extends State<AdditionalManpower> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: OpenDrawerWidget(onClicked: widget.openDrawer,),
        title: const Text('Additional Manpower'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Additional Manpower', 35, 10),
          ],
        ),
      ),
    );
  }
}