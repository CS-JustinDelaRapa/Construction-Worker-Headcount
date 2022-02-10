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

List<TextEditingController> myController = [
  for (int i = 1; i < 11; i++) TextEditingController()
];

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
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomWidgets().text_title('Carpenter', 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: CustomWidgets().textFormField_widget(
                      'Carpenter', Colors.white, 0, myController[1]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
