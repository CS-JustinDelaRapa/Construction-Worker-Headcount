import 'package:engineering/screens/hamburgerMenu/stack.dart';
import 'package:engineering/widget/customWidgets.dart';
import 'package:flutter/material.dart';
import '../homePage.dart';

class CreateProject extends StatefulWidget {
 const  CreateProject({ Key? key}) : super(key: key);

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomWidgets().text_title('Create Project', 35, 10),
            const Flexible(child: SizedBox(height: 10,)),
            CustomWidgets().nav_Button(
                'Back To Home',
                const Icon(Icons.home),
                1,
                context,
                () => const HomePage(),null),
            const Flexible(child: SizedBox(height: 10,)),
            CustomWidgets().nav_Button(
                'Open Dummy Project',
                const Icon(Icons.menu_open),
                1,
                context,
                () => const StackWidget(),null),
          ],
        ),
      ),
    );
  }
}