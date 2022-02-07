import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class LoadProject extends StatefulWidget {
  const LoadProject({Key? key}) : super(key: key);

  @override
  _LoadProjectState createState() => _LoadProjectState();
}

class _LoadProjectState extends State<LoadProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Project'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Load Project', 35),
            const Flexible(
                child: SizedBox(
              height: 10,
            )),
            const Flexible(
                child: SizedBox(
              height: 10,
            )),
            CustomWidgets().nav_Button(
                'Load Dummy Project',
                const Icon(Icons.menu_open),
                context,
                0.6,
                0.05,
                () => const StackWidget(),
                null),
          ],
        ),
      ),
    );
  }
}
